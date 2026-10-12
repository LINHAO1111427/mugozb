"""Opt-in lifecycle and Sub2API registration for the Excel Codex sidecar."""

from __future__ import annotations

import argparse
import base64
import time
import json
import os
from pathlib import Path
import secrets
import subprocess
import sys
import urllib.error
import urllib.parse
import urllib.request


ROOT = Path(__file__).resolve().parent
CONFIG = json.loads((ROOT / "integration.json").read_text(encoding="utf-8"))
RUNTIME = ROOT / ".runtime"
SECRETS = RUNTIME / "secrets"
REGISTRATION = RUNTIME / "registration.json"
CONTAINER = CONFIG["sidecar_container"]
SIDECAR_PORT = int(CONFIG["sidecar_port"])


def _json_output(value: object) -> None:
    print(json.dumps(value, ensure_ascii=False, sort_keys=True))


def _read_secret(name: str) -> str:
    path = SECRETS / name
    if not path.is_file():
        raise RuntimeError(f"missing {path}; run init-secrets first")
    value = path.read_text(encoding="ascii").strip()
    if len(value) < 32 or any(ch.isspace() for ch in value):
        raise RuntimeError(f"invalid {path}")
    return value


def init_secrets() -> None:
    SECRETS.mkdir(parents=True, exist_ok=True)
    for name in ("api-key", "admin-key"):
        path = SECRETS / name
        if path.exists() or path.is_symlink():
            raise RuntimeError(f"refusing to overwrite {path}")
        path.write_text(secrets.token_urlsafe(48) + "\n", encoding="ascii", newline="\n")
        try:
            os.chmod(path, 0o600)
        except OSError:
            pass
    print(f"INITIALIZED_SECRETS {SECRETS}")


def _docker_json(*args: str) -> object:
    return json.loads(subprocess.check_output(["docker", *args], text=True))


def _docker_exec(*args: str, input_bytes: bytes | None = None) -> str:
    command = ["docker", "exec", *( ["-i"] if input_bytes is not None else [] ), CONTAINER, *args]
    result = subprocess.run(command, input=input_bytes, capture_output=True, check=False)
    if result.returncode:
        raise RuntimeError(f"docker exec failed (exit {result.returncode})")
    return result.stdout.decode("utf-8", errors="strict").strip()


def sidecar_status() -> dict:
    raw = _docker_exec("excel-sub2api", "session-status", "--port", str(SIDECAR_PORT))
    try:
        value = json.loads(raw)
    except json.JSONDecodeError as exc:
        raise RuntimeError("sidecar returned invalid session status") from exc
    if not isinstance(value, dict) or not isinstance(value.get("configured"), bool):
        raise RuntimeError("sidecar returned invalid session status")
    return {key: value.get(key) for key in ("configured", "expired", "expires_at", "expires_in_seconds")}


def _source_imports() -> None:
    source = ROOT / "src"
    if str(source) not in sys.path:
        sys.path.insert(0, str(source))


def sync_session(login: str) -> None:
    _source_imports()
    try:
        from excel_codex_bridge.session import SessionReader
        from excel_codex_bridge.sub2api_cli import session_payload
    except ImportError as exc:
        raise RuntimeError("run prepare first to install the bridge dependencies") from exc
    reader = SessionReader(login=login)
    payload = session_payload(reader)
    result = _docker_exec(
        "excel-sub2api", "import-session", "--port", str(SIDECAR_PORT), input_bytes=payload
    )
    try:
        summary = json.loads(result)
    except json.JSONDecodeError as exc:
        raise RuntimeError("sidecar returned invalid import status") from exc
    if not isinstance(summary, dict) or not summary.get("configured") or summary.get("expired"):
        raise RuntimeError("sidecar did not accept a usable session")
    _json_output({"session": {key: summary.get(key) for key in ("configured", "expired", "expires_at", "expires_in_seconds")}})


class Admin:
    """Authenticated admin client for the loopback Sub2API deployment."""

    def __init__(self) -> None:
        self.base = os.environ.get("SUB2API_URL", CONFIG["sub2api_url"]).rstrip("/")
        host = urllib.parse.urlsplit(self.base).hostname
        if host not in {"127.0.0.1", "localhost"}:
            raise RuntimeError("SUB2API_URL must point to the local relay")
        self.opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))
        self.token: str | None = None
        email = os.environ.get("SUB2API_ADMIN_EMAIL")
        password = os.environ.get("SUB2API_ADMIN_PASSWORD")
        if not email or not password:
            try:
                inspected = _docker_json("inspect", "sub2api")
                env = dict(
                    item.split("=", 1)
                    for item in inspected[0]["Config"]["Env"]
                    if "=" in item
                )
                email = email or env.get("ADMIN_EMAIL")
                password = password or env.get("ADMIN_PASSWORD")
            except (OSError, subprocess.SubprocessError, KeyError, IndexError, TypeError, json.JSONDecodeError):
                pass
        if not email or not password:
            raise RuntimeError("set SUB2API_ADMIN_EMAIL and SUB2API_ADMIN_PASSWORD")
        session = self.call("/api/v1/auth/login", {"email": email, "password": password})
        self.token = session["access_token"]

    def call(self, path: str, data: object | None = None, method: str | None = None) -> object:
        headers = {"Content-Type": "application/json"}
        if self.token:
            headers["Authorization"] = "Bearer " + self.token
        encoded = json.dumps(data).encode() if data is not None else None
        request = urllib.request.Request(self.base + path, data=encoded, headers=headers, method=method)
        try:
            with self.opener.open(request, timeout=30) as response:
                value = json.load(response)
        except urllib.error.HTTPError as error:
            detail = error.read().decode("utf-8", errors="replace")[:300]
            raise RuntimeError(f"Sub2API {path} HTTP {error.code}: {detail}") from None
        return value.get("data", value) if isinstance(value, dict) else value


def _state() -> dict:
    if not REGISTRATION.is_file():
        raise RuntimeError("integration is not registered")
    value = json.loads(REGISTRATION.read_text(encoding="utf-8"))
    if not isinstance(value, dict) or "group_id" not in value:
        raise RuntimeError("invalid registration record")
    return value


def _save_state(value: dict) -> None:
    RUNTIME.mkdir(parents=True, exist_ok=True)
    REGISTRATION.write_text(json.dumps(value, indent=2) + "\n", encoding="utf-8")


def _owned_account(admin: Admin, state: dict) -> dict:
    account = admin.call(f"/api/v1/admin/accounts/{state['account_id']}")
    if not isinstance(account, dict):
        raise RuntimeError("invalid account response")
    if account.get("notes") != CONFIG["marker"] or account.get("name") != CONFIG["account_name"]:
        raise RuntimeError("registered account ownership/name changed; review manually")
    if account.get("credentials", {}).get("base_url", "").rstrip("/").removesuffix("/v1") != CONFIG["upstream_url"].rstrip("/").removesuffix("/v1"):
        raise RuntimeError("registered upstream URL changed; review manually")
    return account


def register(admin: Admin) -> None:
    configure_existing(admin)


def configure_existing(admin: Admin) -> None:
    """Point the pre-existing GHCP Excel account at this sidecar."""
    account_id = int(CONFIG["account_id"])
    group_id = int(CONFIG["group_id"])
    account = admin.call(f"/api/v1/admin/accounts/{account_id}")
    group = admin.call(f"/api/v1/admin/groups/{group_id}")
    if account.get("name") != CONFIG["account_name"]:
        raise RuntimeError("account 41 name changed; review it manually")
    if group.get("name") != CONFIG["group_name"]:
        raise RuntimeError("group 9 name changed; review it manually")
    allowed_markers = {
        CONFIG["marker"],
        "Managed by integrations/excel-codex-bridge",
    }
    if account.get("notes") not in allowed_markers or group.get("description") not in allowed_markers:
        raise RuntimeError("existing Excel account/group ownership changed; review it manually")
    credentials = {
        **account.get("credentials", {}),
        "base_url": CONFIG["upstream_url"],
        "api_key": _read_secret("api-key"),
        "model_mapping": {**account.get("credentials", {}).get("model_mapping", {}), **model_mapping()},
    }
    updated = admin.call(
        f"/api/v1/admin/accounts/{account_id}",
        {"credentials": credentials, "notes": CONFIG["marker"], "status": "inactive"},
        "PUT",
    )
    admin.call(f"/api/v1/admin/accounts/{account_id}/schedulable", {"schedulable": False})
    state = {"group_id": group_id, "account_id": account_id, "base_url": CONFIG["upstream_url"]}
    _save_state(state)
    _json_output({**state, "status": updated.get("status", "inactive"), "schedulable": False})


def activate(admin: Admin) -> None:
    state = _state()
    account = _owned_account(admin, state)
    session = sidecar_status()
    if not session["configured"] or session["expired"]:
        raise RuntimeError("sidecar session is not configured or has expired")
    credentials = {
        **account["credentials"],
        "base_url": CONFIG["upstream_url"],
        "api_key": _read_secret("api-key"),
        "model_mapping": {**account.get("credentials", {}).get("model_mapping", {}), **model_mapping()},
    }
    admin.call(
        f"/api/v1/admin/accounts/{state['account_id']}",
        {"credentials": credentials, "status": "active"},
        "PUT",
    )
    admin.call(f"/api/v1/admin/accounts/{state['account_id']}/schedulable", {"schedulable": True})
    _json_output({**state, "status": "active", "schedulable": True, "session": session})


def status(admin: Admin) -> None:
    result = {"registered": REGISTRATION.exists(), "sidecar": None}
    try:
        result["sidecar"] = sidecar_status()
    except (OSError, RuntimeError, subprocess.SubprocessError) as exc:
        result["sidecar"] = {"error": str(exc)}
    if REGISTRATION.exists():
        state = _state()
        account = _owned_account(admin, state)
        result.update({"registration": state, "status": account.get("status"), "schedulable": account.get("schedulable")})
    _json_output(result)


def remove(admin: Admin) -> None:
    state = _state()
    if "account_id" in state:
        _owned_account(admin, state)
        admin.call(f"/api/v1/admin/accounts/{state['account_id']}", method="DELETE")
        del state["account_id"]
        _save_state(state)
    group = admin.call(f"/api/v1/admin/groups/{state['group_id']}")
    if group.get("description") != CONFIG["marker"] or group.get("name") != CONFIG["group_name"]:
        raise RuntimeError("group was repurposed; preserve it for manual review")
    keys = admin.call(f"/api/v1/admin/groups/{state['group_id']}/api-keys")
    accounts = admin.call("/api/v1/admin/accounts?" + urllib.parse.urlencode({"group": state["group_id"], "page_size": 100}))
    if keys.get("items") or keys.get("total", 0) or accounts.get("items") or accounts.get("total", 0):
        raise RuntimeError("group has new bindings; keep it for manual review")
    admin.call(f"/api/v1/admin/groups/{state['group_id']}", method="DELETE")
    REGISTRATION.unlink()
    print("REMOVED_EXCEL_CODEX_BRIDGE")



def model_mapping() -> dict:
    mapping = {model: model for model in CONFIG["models"]}
    mapping.update({model.removesuffix("-excel"): model for model in CONFIG["models"] if not model.endswith("-1m-excel")})
    return mapping


def repair_existing(admin: Admin, probe_model: str = "gpt-6-sol-excel") -> None:
    """Repair routing, then clear old failures only after a real completed response."""
    state = _state()
    account = _owned_account(admin, state)
    credentials = {**account["credentials"], "base_url": CONFIG["upstream_url"],
                   "model_mapping": {**account["credentials"].get("model_mapping", {}), **model_mapping()}}
    admin.call(f"/api/v1/admin/accounts/{state['account_id']}", {"credentials": credentials}, "PUT")
    check = r'''import json,os,sys,urllib.request,urllib.error
key=open(os.environ['EXCEL_SUB2API_API_KEY_FILE']).read().strip()
body={'model':sys.argv[1],'input':'Return exactly BRIDGE_READY.','stream':False,'store':False,'reasoning':{'effort':'low'}}
r=urllib.request.Request('http://127.0.0.1:8000/v1/responses',data=json.dumps(body).encode(),headers={'Authorization':'Bearer '+key,'Content-Type':'application/json'})
try:
 with urllib.request.build_opener(urllib.request.ProxyHandler({})).open(r,timeout=60) as response: p=json.load(response);code=response.status
except urllib.error.HTTPError as e:
 code=e.code;p={}
print(json.dumps({'http_status':code,'status':p.get('status')}))
'''
    result = json.loads(_docker_exec("python", "-c", check, probe_model))
    if result.get("http_status") != 200 or result.get("status") != "completed":
        raise RuntimeError("bridge recovery probe did not complete; existing scheduling state retained")
    n = state["account_id"]
    admin.call(f"/api/v1/admin/accounts/{n}/clear-error", method="POST")
    admin.call(f"/api/v1/admin/accounts/{n}/clear-rate-limit", method="POST")
    admin.call(f"/api/v1/admin/accounts/{n}/temp-unschedulable", method="DELETE")
    admin.call(f"/api/v1/admin/accounts/{n}", {"status": "active"}, "PUT")
    admin.call(f"/api/v1/admin/accounts/{n}/schedulable", {"schedulable": True})
    state["base_url"] = CONFIG["upstream_url"]
    _save_state(state)
    _json_output({"account_id": n, "base_url": state["base_url"], "status": "active", "schedulable": True, "probe": {"model": probe_model, **result}})


def sync_account(admin: Admin, source_id: int, probe_model: str = "gpt-6-sol-excel") -> None:
    source = admin.call(f"/api/v1/admin/accounts/{source_id}")
    if source.get("platform") != "openai" or source.get("type") != "oauth":
        raise RuntimeError("source must be an OpenAI OAuth account")
    credentials = source.get("credentials") or {}
    if not credentials.get("access_token"):
        # Admin GET deliberately redacts tokens; read this local source only in memory.
        query = "select credentials::text from accounts where id=" + str(int(source_id)) + " and deleted_at is null and platform='openai' and type='oauth'"
        result = subprocess.run(["docker", "exec", "sub2api-postgres", "psql", "-U", "sub2api", "-d", "sub2api", "-Atc", query], capture_output=True, check=False)
        if result.returncode or not result.stdout.strip():
            raise RuntimeError("local source credentials could not be read")
        credentials = json.loads(result.stdout)
    token = credentials.get("access_token", "")
    try:
        part = token.split(".")[1]
        claims = json.loads(base64.urlsafe_b64decode(part + "=" * (-len(part) % 4)))
    except (IndexError, ValueError):
        raise RuntimeError("source token is not a usable JWT") from None
    auth = claims.get("https://api.openai.com/auth", {})
    aid = credentials.get("chatgpt_account_id")
    if not aid or aid != auth.get("chatgpt_account_id") or claims.get("exp", 0) <= time.time() + 300:
        raise RuntimeError("source token identity or expiry check failed")
    headers = {"authorization": "Bearer " + token, "chatgpt-account-id": aid,
               "x-openai-account-id": aid, "x-basispoints-auth-mode": "chatgpt"}
    if auth.get("chatgpt_account_user_id"):
        headers["x-openai-account-user-id"] = auth["chatgpt_account_user_id"]
    imported = json.loads(_docker_exec("excel-sub2api", "import-session", "--port", str(SIDECAR_PORT),
                                     input_bytes=json.dumps({"headers": headers}).encode()))
    if not imported.get("configured") or imported.get("expired"):
        raise RuntimeError("source session import failed")
    repair_existing(admin, probe_model)


def prepare() -> None:
    source = ROOT / "src" / "excel_codex_bridge"
    if not source.joinpath("sub2api.py").is_file() or not (ROOT / "UPSTREAM_REVISION.txt").is_file():
        raise RuntimeError("vendored bridge source is incomplete")
    lines = [line.strip() for line in (ROOT / "UPSTREAM_REVISION.txt").read_text(encoding="utf-8").splitlines() if line.strip()]
    print("PREPARED revision=" + lines[-1])


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Opt-in Excel Codex sidecar integration")
    sub = parser.add_subparsers(dest="action", required=True)
    sub.add_parser("prepare")
    sub.add_parser("init-secrets")
    sync = sub.add_parser("sync-session")
    sync.add_argument("--login", choices=("auto", "codex", "excel"), default="auto")
    sync_account_parser = sub.add_parser("sync-account")
    sync_account_parser.add_argument("--source-account-id", type=int, default=CONFIG.get("source_account_id", 48))
    sync_account_parser.add_argument("--probe-model", choices=CONFIG["models"], default="gpt-6-sol-excel")
    repair_parser = sub.add_parser("repair")
    repair_parser.add_argument("--probe-model", choices=CONFIG["models"], default="gpt-6-sol-excel")
    for action in ("configure-existing", "register", "activate", "status", "remove"):
        sub.add_parser(action)
    args = parser.parse_args(argv)
    try:
        if args.action == "prepare":
            prepare()
        elif args.action == "init-secrets":
            init_secrets()
        elif args.action == "sync-session":
            sync_session(args.login)
        else:
            admin = Admin()
            if args.action == "sync-account":
                sync_account(admin, args.source_account_id, args.probe_model)
            elif args.action == "repair":
                repair_existing(admin, args.probe_model)
            else:
                action = "configure_existing" if args.action == "configure-existing" else args.action
                globals()[action](admin)
    except (OSError, RuntimeError, KeyError, ValueError, subprocess.SubprocessError) as exc:
        print(str(exc), file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
