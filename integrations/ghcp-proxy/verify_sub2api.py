"""Exercise the running local Sub2API against an isolated ASGI fixture."""
import asyncio
import argparse
import json
import secrets
import socket
import threading
import time
import urllib.request
import uuid

import uvicorn
from bridge import Bridge
from register import Admin


def main(provider):
    key = secrets.token_urlsafe(40)
    seen = []
    model = "gpt-5.6-sol-excel" if provider == "excel" else "ghcp-fixture"
    prefix = "/excel" if provider == "excel" else ""

    async def fixture(scope, receive, send):
        raw = b""
        while True:
            event = await receive()
            raw += event.get("body", b"")
            if not event.get("more_body"):
                break
        payload = json.loads(raw) if raw else {}
        seen.append({"path": scope["path"], "model": payload.get("model"),
                     "stream": payload.get("stream"),
                     "authorization_stripped": not any(k == b"authorization" for k, _ in scope["headers"])})
        result = {"id": "resp_fixture", "object": "response", "status": "completed",
                  "model": payload.get("model", "ghcp-fixture"), "output": [],
                  "usage": {"input_tokens": 1, "output_tokens": 1, "total_tokens": 2}}
        if not payload.get("stream"):
            result["output"] = [{"type": "function_call", "id": "fc_fixture", "call_id": "call_fixture",
                                 "name": "probe_ping", "arguments": "{\"ok\":true}"}]
            return await Bridge.reply(send, 200, result)
        await send({"type": "http.response.start", "status": 200,
                    "headers": [(b"content-type", b"text/event-stream")]})
        for event in [
            {"type": "response.created", "response": {**result, "status": "in_progress"}},
            {"type": "response.output_text.delta", "delta": "GHCP_FIXTURE_OK"},
            {"type": "response.completed", "response": result},
        ]:
            await send({"type": "http.response.body", "body": ("data: " + json.dumps(event) + "\n\n").encode(), "more_body": True})
            await asyncio.sleep(.01)
        await send({"type": "http.response.body", "body": b""})

    app = Bridge(fixture, key, status=lambda: {"authenticated": provider == "copilot"},
                 excel_status=lambda: {"configured": provider == "excel"},
                 excel_models=("gpt-5.6-sol-excel",))
    listener = socket.socket()
    listener.bind(("127.0.0.1", 0))
    port = listener.getsockname()[1]
    server = uvicorn.Server(uvicorn.Config(app, lifespan="off", access_log=False, log_level="error"))
    thread = threading.Thread(target=lambda: asyncio.run(server.serve(sockets=[listener])), daemon=True)
    thread.start()
    for _ in range(50):
        if server.started:
            break
        time.sleep(.1)
    assert server.started
    admin = Admin()
    group_id = account_id = None
    try:
        group = admin.call("/api/v1/admin/groups", {
            "name": "ghcp-fixture-" + uuid.uuid4().hex[:8], "platform": "openai",
            "rate_multiplier": 1, "is_exclusive": True, "subscription_type": "standard"})
        group_id = group["id"]
        account = admin.call("/api/v1/admin/accounts", {
            "name": "GHCP isolated contract fixture", "platform": "openai", "type": "apikey",
            "credentials": {"base_url": f"http://host.docker.internal:{port}{prefix}/v1", "api_key": key,
                            "model_mapping": {model: model}},
            "extra": {"openai_passthrough": True, "openai_responses_mode": "force_responses"},
            "concurrency": 1, "group_ids": [group_id], "upstream_billing_probe_enabled": False})
        account_id = account["id"]
        req = urllib.request.Request(admin.base + f"/api/v1/admin/accounts/{account_id}/test",
            data=json.dumps({"model_id": model, "prompt": "fixture", "mode": "responses"}).encode(),
            headers={"Content-Type": "application/json", "Authorization": "Bearer " + admin.token})
        with admin.opener.open(req, timeout=30) as response:
            text = response.read().decode()
            assert response.status == 200
        events = [json.loads(line[5:]) for line in text.splitlines() if line.startswith("data:")]
        assert any(e.get("text") == "GHCP_FIXTURE_OK" for e in events), events
        assert any(e.get("type") == "test_complete" and e.get("success") for e in events), events
        assert any(s["path"] == "/v1/responses" and s["stream"] for s in seen), seen
        assert all(s["model"] == model for s in seen), seen
        assert all(s["authorization_stripped"] for s in seen)
        print(f"SUB2API_CONTRACT_OK provider={provider} HTTP=200 SSE=GHCP_FIXTURE_OK test_complete=true upstream_path=/v1/responses")
    finally:
        if account_id:
            admin.call(f"/api/v1/admin/accounts/{account_id}", method="DELETE")
        if group_id:
            admin.call(f"/api/v1/admin/groups/{group_id}", method="DELETE")
        server.should_exit = True
        thread.join(timeout=10)
        listener.close()
        assert not thread.is_alive()
        print(f"FIXTURE_CLEANUP_OK provider={provider} account_removed=true group_removed=true listener_stopped=true")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--provider", choices=["copilot", "excel", "both"], default="both")
    args = parser.parse_args()
    for provider in (["copilot", "excel"] if args.provider == "both" else [args.provider]):
        main(provider)
