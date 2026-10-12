"""Explicit, repeatable per-source accounts using the shared Excel bridge image.

OAuth material travels only through Docker stdin to an isolated memory session.
Source accounts and other bridge instances are never updated by this helper.
"""
from __future__ import annotations

import argparse
import base64
import hashlib
import json
import os
from pathlib import Path
import secrets
import subprocess
import sys
import time

import manage

DEFAULT_IMAGE = "excel-codex-bridge:quality-20261001"
NETWORK = "deploy_sub2api-network"
RUNTIME = manage.RUNTIME / "accounts"


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def run(args, payload=None, timeout=120):
    result = subprocess.run(args, input=payload, capture_output=True, timeout=timeout)
    if result.returncode:
        # stdout/stderr may include private configuration; never echo them.
        raise RuntimeError(f"{args[0]} command failed with exit {result.returncode}")
    return result.stdout


def source_account(source_id):
    source_id = positive_id(source_id)
    query = ("select json_build_object('id',id,'platform',platform,'type',type,"
             "'credentials',credentials,'concurrency',concurrency,'rate_multiplier',rate_multiplier) "
             f"from accounts where id={source_id} and deleted_at is null")
    rows = run(["docker", "exec", "sub2api-postgres", "psql", "-U", "sub2api", "-d", "sub2api", "-Atc", query]).splitlines()
    if len(rows) != 1:
        raise RuntimeError("Expected one existing local source account")
    return json.loads(rows[0])


def positive_id(value):
    value = int(value)
    if value < 1:
        raise ValueError("Account/group ID must be positive")
    return value


def session_payload(source):
    if source.get("platform") != "openai" or source.get("type") != "oauth":
        raise RuntimeError("Source must be an OpenAI OAuth account")
    credentials = source.get("credentials") or {}
    try:
        token = credentials["access_token"]
        part = token.split(".")[1]
        claims = json.loads(base64.urlsafe_b64decode(part + "=" * (-len(part) % 4)))
        auth = claims["https://api.openai.com/auth"]
        account_id = credentials["chatgpt_account_id"]
        if not account_id or account_id != auth.get("chatgpt_account_id") or claims["exp"] <= time.time() + 300:
            raise ValueError("identity/expiry")
    except (KeyError, IndexError, TypeError, ValueError):
        raise RuntimeError("Source OAuth identity/expiry validation failed") from None
    headers = {"authorization": "Bearer " + token, "chatgpt-account-id": account_id,
               "x-openai-account-id": account_id, "x-basispoints-auth-mode": "chatgpt"}
    if auth.get("chatgpt_account_user_id"):
        headers["x-openai-account-user-id"] = auth["chatgpt_account_user_id"]
    return json.dumps({"headers": headers}).encode()


def mapping():
    manage._source_imports()
    from excel_codex_bridge.excel_upstream import MODEL_IDS
    return {key: model for model in MODEL_IDS for key in (model, model.removesuffix("-excel"))}


PROBE_CODE = r'''
import json, os, sys, time, urllib.request, urllib.error
body=json.load(sys.stdin)
key=open(os.environ['EXCEL_SUB2API_API_KEY_FILE']).read().strip()
started=time.perf_counter(); first=None; payload={}; errors=[]; kinds=[]
req=urllib.request.Request('http://127.0.0.1:8000/v1/responses',data=json.dumps(body).encode(),headers={'Authorization':'Bearer '+key,'Content-Type':'application/json'})
try:
 with urllib.request.build_opener(urllib.request.ProxyHandler({})).open(req,timeout=90) as r:
  code=r.status
  if 'text/event-stream' in r.headers.get('content-type',''):
   for line in r:
    if not line.startswith(b'data:'):continue
    try:p=json.loads(line[5:])
    except ValueError:continue
    kind=p.get('type','');kinds.append(kind)
    if first is None and kind in ('response.output_text.delta','response.function_call_arguments.delta'):first=time.perf_counter()-started
    if kind in ('response.completed','response.failed','response.incomplete'):
     payload=p.get('response',{});break
  else:payload=json.load(r)
except urllib.error.HTTPError as e:
 code=e.code
 try:payload=json.load(e)
 except ValueError:payload={}
except Exception as e:
 print(json.dumps({'http_status':None,'transport_error':type(e).__name__}));sys.exit(0)
text=''.join(c.get('text','') for i in payload.get('output',[]) if isinstance(i,dict) for c in i.get('content',[]) if isinstance(c,dict))
error=payload.get('error') or {}
print(json.dumps({'http_status':code,'status':payload.get('status'),'model':payload.get('model'),'text':text[:200],
 'error':{k:error[k] for k in ('code','type','message','upstream_model','requested_model') if k in error},
 'first_token_ms':round(first*1000,2) if first is not None else None,'duration_ms':round((time.perf_counter()-started)*1000,2),
 'events':kinds,'usage':payload.get('usage')}))
'''


class AccountBridge:
    def __init__(self, source_id, admin=None):
        self.source_id = positive_id(source_id)
        self.container = f"excel-codex-account{self.source_id}"
        self.marker = f"Managed by excel-codex-bridge/bridge_accounts; source_account_id={self.source_id}"
        self.base_url = f"http://{self.container}:8000"
        self.directory = RUNTIME / str(self.source_id)
        self.state_path = self.directory / "state.json"
        self.admin = admin

    def save(self, state):
        self.directory.mkdir(parents=True, exist_ok=True)
        temporary = self.state_path.with_suffix(".tmp")
        temporary.write_text(json.dumps(state, indent=2) + "\n", encoding="utf-8")
        temporary.replace(self.state_path)

    def state(self):
        return json.loads(self.state_path.read_text()) if self.state_path.exists() else {}

    def inspect(self):
        result = subprocess.run(["docker", "inspect", self.container], capture_output=True)
        if result.returncode:
            return None
        value = json.loads(result.stdout)[0]
        if value["Config"].get("Labels", {}).get("sub2api.excel.owner") != self.marker:
            raise RuntimeError("Container name belongs to another bridge; no changes made")
        return value

    def owned_account(self, state):
        account = self.admin.call(f"/api/v1/admin/accounts/{state['account_id']}")
        if account.get("notes") != self.marker or (account.get("credentials") or {}).get("base_url") != self.base_url:
            raise RuntimeError("Bridge account ownership/URL changed; no account update made")
        return account

    def sync(self):
        if self.inspect() is None:
            raise RuntimeError("Create the bridge container first")
        source = source_account(self.source_id)
        result = json.loads(run(["docker", "exec", "-i", self.container, "excel-sub2api", "import-session", "--port", "8000"], session_payload(source)))
        if not result.get("configured") or result.get("expired"):
            raise RuntimeError("Bridge rejected the source session")
        return {"source_account_id": self.source_id, **{k: result.get(k) for k in ("configured", "expired", "expires_at")}}

    def create(self, image, group_ids, network=NETWORK):
        group_ids = sorted({positive_id(n) for n in group_ids})
        for group_id in group_ids:
            group = self.admin.call(f"/api/v1/admin/groups/{group_id}")
            if group.get("platform") != "openai":
                raise RuntimeError("Each bridge group must use the OpenAI platform")
        source = source_account(self.source_id)
        session_payload(source)  # validate before creating any external object
        state = self.state()
        if state and (state.get("image") != image or state.get("group_ids") != group_ids):
            raise RuntimeError("Existing bridge image/groups differ; review its saved state")
        self.directory.mkdir(parents=True, exist_ok=True)
        if os.name == "nt":
            principal = run(["whoami"]).decode().strip()
            run(["icacls", str(self.directory), "/inheritance:r", "/grant:r", principal + ":(OI)(CI)F", "*S-1-5-18:(OI)(CI)F"])
        else:
            self.directory.chmod(0o700)
        for name in ("api-key", "admin-key"):
            path = self.directory / name
            if not path.exists():
                with path.open("x", encoding="ascii") as stream:
                    stream.write(secrets.token_urlsafe(48) + "\n")
                path.chmod(0o600)
        state = state or {"source_account_id": self.source_id, "container": self.container,
                          "image": image, "group_ids": group_ids, "base_url": self.base_url}
        self.save(state)
        existing = self.inspect()
        if existing is None:
            config = {"services": {self.container: {
                "image": image, "container_name": self.container, "restart": "unless-stopped",
                "read_only": True, "security_opt": ["no-new-privileges:true"], "cap_drop": ["ALL"],
                "tmpfs": ["/tmp:size=64m,mode=1777"], "labels": {"sub2api.excel.owner": self.marker},
                "environment": {"EXCEL_SUB2API_API_KEY_FILE": "/run/secrets/api-key", "EXCEL_SUB2API_ADMIN_KEY_FILE": "/run/secrets/admin-key"},
                "volumes": [str((self.directory / name).resolve()).replace("\\", "/") + f":/run/secrets/{name}:ro" for name in ("api-key", "admin-key")],
                "networks": ["existing"], "healthcheck": {"test": ["CMD", "python", "-c", "import urllib.request;urllib.request.urlopen('http://127.0.0.1:8000/healthz',timeout=3).close()"], "interval": "30s", "timeout": "5s", "retries": 3},
            }}, "networks": {"existing": {"external": True, "name": network}}}
            compose = self.directory / "compose.json"
            compose.write_text(json.dumps(config, indent=2), encoding="utf-8")
            run(["docker", "compose", "-p", f"excel-account{self.source_id}", "-f", str(compose), "up", "-d", "--no-build", "--pull", "never"], timeout=120)
        elif existing["Config"]["Image"] != image:
            raise RuntimeError("Existing container uses another image")
        for attempt in range(20):
            try:
                run(["docker", "exec", self.container, "excel-sub2api", "session-status", "--port", "8000"])
                break
            except RuntimeError:
                if attempt == 19:
                    raise
                time.sleep(0.5)
        self.sync()
        if "account_id" not in state:
            # Recover a creation interrupted before state.json was persisted.
            query = f"select id from accounts where notes='{self.marker}' and deleted_at is null"
            ids = run(["docker", "exec", "sub2api-postgres", "psql", "-U", "sub2api", "-d", "sub2api", "-Atc", query]).splitlines()
            if len(ids) > 1:
                raise RuntimeError("More than one managed account exists")
            if ids:
                state["account_id"] = int(ids[0])
            else:
                account = self.admin.call("/api/v1/admin/accounts", {
                    "name": f"ChatGPT Excel - account {self.source_id}", "notes": self.marker,
                    "platform": "openai", "type": "apikey", "credentials": {
                        "base_url": self.base_url, "api_key": (self.directory / "api-key").read_text().strip(), "model_mapping": mapping(),
                    }, "extra": {"openai_passthrough": True, "openai_responses_mode": "force_responses",
                                  "openai_responses_supported": True, "openai_apikey_responses_websockets_v2_enabled": False,
                                  "openai_apikey_responses_websockets_v2_mode": "off",
                                  "upstream_billing_probe_enabled": False, "upstream_billing_rate_sync_enabled": False}, "concurrency": source["concurrency"],
                    "priority": 0, "rate_multiplier": source["rate_multiplier"], "group_ids": [],
                    "upstream_billing_probe_enabled": False,
                })
                state["account_id"] = account["id"]
            self.save(state)
            self.owned_account(state)
            self.admin.call(f"/api/v1/admin/accounts/{state['account_id']}/schedulable", {"schedulable": False})
            self.admin.call(f"/api/v1/admin/accounts/{state['account_id']}", {"status": "inactive", "group_ids": group_ids}, "PUT")
        self.owned_account(state)
        return {**state, "session": self.status()["session"]}

    def probe(self, model="gpt-6-sol-excel", stream=False):
        if model not in mapping():
            raise RuntimeError("Unknown bridge model")
        self.inspect()
        body = {"model": model, "input": "Return exactly BRIDGE_ACCOUNT_OK.", "stream": stream, "store": False, "reasoning": {"effort": "low"}}
        return json.loads(run(["docker", "exec", "-i", self.container, "python", "-c", PROBE_CODE], json.dumps(body).encode(), timeout=110))

    def activate(self, model):
        state = self.state()
        self.owned_account(state)
        result = self.probe(model)
        expected = mapping()[model].removesuffix("-1m-excel").removesuffix("-excel")
        reported = result.get("model") or ""
        actual = mapping().get(reported, reported).removesuffix("-1m-excel").removesuffix("-excel")
        if result.get("http_status") != 200 or result.get("status") != "completed" or actual != expected or result.get("text", "").strip() != "BRIDGE_ACCOUNT_OK":
            state["last_probe"] = result
            self.save(state)
            raise RuntimeError("Provider probe did not complete with the requested model; account not activated (see state.json)")
        self.admin.call(f"/api/v1/admin/accounts/{state['account_id']}", {"status": "active"}, "PUT")
        self.admin.call(f"/api/v1/admin/accounts/{state['account_id']}/schedulable", {"schedulable": True})
        state["last_probe"] = result
        self.save(state)
        return self.status()

    def status(self):
        state = self.state()
        info = self.inspect()
        result = {**state, "container_id": info["Id"] if info else None,
                  "health": (info or {}).get("State", {}).get("Health", {}).get("Status")}
        if info:
            result["session"] = json.loads(run(["docker", "exec", self.container, "excel-sub2api", "session-status", "--port", "8000"]))
        if state.get("account_id"):
            account = self.owned_account(state)
            result["account"] = {k: account.get(k) for k in ("id", "status", "schedulable", "group_ids")}
        return result

    def remove(self):
        """Explicit rollback of this helper's bridge; never the OAuth source."""
        state = self.state()
        account_id = state.get("account_id")
        if not account_id or account_id == self.source_id:
            raise RuntimeError("No distinct managed bridge account to remove")
        self.owned_account(state)
        info = self.inspect()  # verify both ownership boundaries before writes
        self.admin.call(f"/api/v1/admin/accounts/{account_id}/schedulable", {"schedulable": False})
        self.admin.call(f"/api/v1/admin/accounts/{account_id}", method="DELETE")
        if info:
            run(["docker", "rm", "-f", self.container])
        state["removed_account_id"] = state.pop("account_id")
        state.pop("last_probe", None)
        self.save(state)
        return {"removed_account_id": account_id, "source_account_id": self.source_id,
                "source_unchanged": True, "container_removed": info is not None}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("action", choices=("create", "sync", "probe", "activate", "status", "remove"))
    parser.add_argument("--source-account-id", type=positive_id, required=True)
    parser.add_argument("--image", default=DEFAULT_IMAGE)
    parser.add_argument("--group-id", type=positive_id, action="append")
    parser.add_argument("--network", default=NETWORK)
    parser.add_argument("--probe-model", default="gpt-6-sol-excel")
    parser.add_argument("--stream", action="store_true")
    args = parser.parse_args()
    try:
        bridge = AccountBridge(args.source_account_id, manage.Admin())
        if args.action == "create":
            if not args.group_id:
                raise RuntimeError("create requires an explicit --group-id")
            result = bridge.create(args.image, args.group_id, args.network)
        elif args.action == "activate":
            result = bridge.activate(args.probe_model)
        elif args.action == "probe":
            result = bridge.probe(args.probe_model, args.stream)
        else:
            result = getattr(bridge, args.action)()
        print(json.dumps(result, ensure_ascii=True, sort_keys=True))
        return 0
    except (OSError, ValueError, RuntimeError, subprocess.SubprocessError) as exc:
        print(str(exc), file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
