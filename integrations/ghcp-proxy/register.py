"""Register only this integration's account/group in the local Sub2API."""
import argparse
import json
from pathlib import Path
import subprocess
import sys
import urllib.error
import urllib.parse
import urllib.request

from manage import CONFIG, ROOT, RUNTIME, health

def settings(provider):
    prefix = "excel_" if provider == "excel" else ""
    label = "ChatGPT Excel" if provider == "excel" else "GitHub Copilot"
    return {"marker": "Managed by integrations/ghcp-proxy; provider=" + label,
            "record": RUNTIME / (prefix + "registration.json"),
            "name": CONFIG[prefix + "account_name"], "group": CONFIG[prefix + "group_name"],
            "url": CONFIG[prefix + "sub2api_upstream_url"]}


class Admin:
    def __init__(self):
        self.base = CONFIG["sub2api_url"].rstrip("/")
        if urllib.parse.urlsplit(self.base).hostname not in ("127.0.0.1", "localhost"):
            raise ValueError("This helper manages only the local Sub2API")
        self.opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))
        self.token = None
        container = json.loads(subprocess.check_output(["docker", "inspect", "sub2api"]))[0]
        env = dict(s.split("=", 1) for s in container["Config"]["Env"] if "=" in s)
        session = self.call("/api/v1/auth/login", {
            "email": env["ADMIN_EMAIL"], "password": env["ADMIN_PASSWORD"]})
        self.token = session["access_token"]

    def call(self, path, data=None, method=None):
        headers = {"Content-Type": "application/json"}
        if self.token:
            headers["Authorization"] = "Bearer " + self.token
        req = urllib.request.Request(self.base + path,
            data=json.dumps(data).encode() if data is not None else None,
            headers=headers, method=method)
        try:
            with self.opener.open(req, timeout=30) as response:
                value = json.load(response)
        except urllib.error.HTTPError as error:
            # Never serialize admin credentials or account responses into logs.
            raise RuntimeError(f"Sub2API {path} HTTP {error.code}: " + error.read().decode()[:400]) from None
        return value.get("data", value)


def save(state, spec):
    spec["record"].write_text(json.dumps(state, indent=2) + "\n")


def owned_account(admin, state, spec):
    account = admin.call(f'/api/v1/admin/accounts/{state["account_id"]}')
    if account.get("notes") != spec["marker"] or account.get("name") != spec["name"]:
        raise RuntimeError("Registered account has changed ownership/name; review it manually")
    if account.get("credentials", {}).get("base_url") != spec["url"]:
        raise RuntimeError("Registered upstream URL has changed; review it manually")
    return account


def register(admin, provider):
    spec = settings(provider)
    state = json.loads(spec["record"].read_text()) if spec["record"].exists() else {}
    if "account_id" in state:
        account = owned_account(admin, state, spec)
        print(json.dumps({**state, "provider": provider, "status": account["status"], "existing": True}))
        return
    # A unique exclusive group keeps this unauthenticated upstream out of the
    # existing routing pool while the user completes provider login.
    if "group_id" not in state:
        groups = admin.call("/api/v1/admin/groups/all")
        if any(g["name"] == spec["group"] for g in groups):
            raise RuntimeError("Group name already exists without an ownership record")
        group = admin.call("/api/v1/admin/groups", {"name": spec["group"],
            "description": spec["marker"], "platform": "openai", "rate_multiplier": 1,
            "is_exclusive": True, "subscription_type": "standard", "require_oauth_only": False,
            "require_privacy_set": False})
        state = {"group_id": group["id"], "base_url": spec["url"]}
        save(state, spec)
    payload = {
        "name": spec["name"], "notes": spec["marker"], "platform": "openai", "type": "apikey",
        "credentials": {"base_url": spec["url"],
                        "api_key": (RUNTIME / "bridge-key").read_text().strip()},
        "extra": {"openai_passthrough": True, "openai_responses_mode": "force_responses"},
        "concurrency": 2, "priority": 50, "group_ids": [state["group_id"]],
        "upstream_billing_probe_enabled": False,
    }
    account = admin.call("/api/v1/admin/accounts", payload)
    state["account_id"] = account["id"]
    save(state, spec)
    admin.call(f'/api/v1/admin/accounts/{account["id"]}', {"status": "inactive"}, "PUT")
    admin.call(f'/api/v1/admin/accounts/{account["id"]}/schedulable', {"schedulable": False})
    print(json.dumps({**state, "provider": provider, "status": "inactive", "provider_login_required": True}))


def activate(admin, provider):
    spec = settings(provider)
    state = json.loads(spec["record"].read_text())
    account = owned_account(admin, state, spec)
    if provider == "excel":
        with admin.opener.open(f'http://127.0.0.1:{CONFIG["listen_port"]}/api/config/excel-session', timeout=30) as response:
            response.read()
    readiness = health()
    if not readiness["enabled"] or not readiness["providers"][provider]["ready"]:
        raise RuntimeError(provider + " login required; see http://127.0.0.1:8000/ui")
    model_path = urllib.parse.urlsplit(spec["url"]).path.rstrip("/") + "/models"
    req = urllib.request.Request(f'http://127.0.0.1:{CONFIG["listen_port"]}' + model_path,
        headers={"Authorization": "Bearer " + (RUNTIME / "bridge-key").read_text().strip()})
    with admin.opener.open(req, timeout=90) as response:
        data = json.load(response)
    models = sorted({x["id"] for x in data.get("data", []) if isinstance(x.get("id"), str)})
    if not models:
        raise RuntimeError("Provider returned no usable models; account remains inactive")
    credentials = {**account["credentials"], "model_mapping": {model: model for model in models}}
    admin.call(f'/api/v1/admin/accounts/{state["account_id"]}', {
        "credentials": credentials, "status": "active"}, "PUT")
    admin.call(f'/api/v1/admin/accounts/{state["account_id"]}/schedulable', {"schedulable": True})
    (RUNTIME / (provider + "_models.json")).write_text(json.dumps(models, indent=2))
    print(json.dumps({**state, "provider": provider, "status": "active", "model_count": len(models)}))


def remove(admin, provider):
    spec = settings(provider)
    state = json.loads(spec["record"].read_text())
    if "account_id" in state:
        owned_account(admin, state, spec)
        admin.call(f'/api/v1/admin/accounts/{state["account_id"]}', method="DELETE")
        del state["account_id"]
        save(state, spec)
    group = admin.call(f'/api/v1/admin/groups/{state["group_id"]}')
    if group.get("description") != spec["marker"] or group.get("name") != spec["group"]:
        raise RuntimeError("Group was repurposed; preserve it for manual review")
    keys = admin.call(f'/api/v1/admin/groups/{state["group_id"]}/api-keys')
    accounts = admin.call('/api/v1/admin/accounts?' + urllib.parse.urlencode({"group": state["group_id"], "page_size": 100}))
    if keys.get("items") or keys.get("total", 0) or accounts.get("items") or accounts.get("total", 0):
        raise RuntimeError("Group has new bindings; keep it for manual review")
    admin.call(f'/api/v1/admin/groups/{state["group_id"]}', method="DELETE")
    spec["record"].unlink()
    print("REMOVED_LOCAL_GHCP_REGISTRATION provider=" + provider)


def status(admin, provider):
    spec = settings(provider)
    if not spec["record"].exists():
        print(json.dumps({"provider": provider, "registered": False}))
        return
    state = json.loads(spec["record"].read_text())
    account = owned_account(admin, state, spec)
    print(json.dumps({**state, "provider": provider, "status": account["status"],
                      "schedulable": account["schedulable"], "health": health()["providers"][provider]}))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("action", choices=["register", "activate", "remove", "status"])
    parser.add_argument("--provider", choices=["copilot", "excel", "both"], default="both")
    args = parser.parse_args()
    admin = Admin()
    failed = False
    for provider in (["copilot", "excel"] if args.provider == "both" else [args.provider]):
        try:
            globals()[args.action](admin, provider)
        except (RuntimeError, OSError, KeyError) as error:
            print(json.dumps({"provider": provider, "error": str(error)}), file=sys.stderr)
            failed = True
    raise SystemExit(1 if failed else 0)
