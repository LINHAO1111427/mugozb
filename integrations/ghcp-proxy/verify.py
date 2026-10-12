"""Offline provider isolation, ASGI streaming and login lifecycle contracts."""
import argparse
import asyncio
import json
from pathlib import Path

from bridge import Bridge

KEY = "fixture-integration-key-" + "x" * 40
MODELS = ("gpt-6-astra-excel", "gpt-5.6-luna-excel", "gpt-5.6-terra-excel", "gpt-5.6-sol-excel")


async def verify(config):
    calls = []
    github = {"authenticated": True, "token": "never-return-this"}
    excel = {"configured": True, "expired": False, "token": "never-return-this"}
    refresh_calls = []

    async def refresh():
        refresh_calls.append(True)

    async def upstream(scope, receive, send):
        chunks = []
        while True:
            message = await receive()
            chunks.append(message)
            if not message.get("more_body"):
                break
        raw = b"".join(m.get("body", b"") for m in chunks)
        calls.append({"scope": scope, "body": raw, "chunks": chunks})
        if scope["path"] == "/api/config/excel-session":
            return await Bridge.reply(send, 200, {"configured": excel["configured"]})
        if scope["path"] == "/v1/models":
            return await Bridge.reply(send, 200, {"object": "list", "data": [
                {"id": "fixture-model"}, *({"id": m} for m in MODELS)]})
        payload = json.loads(raw)
        if payload.get("fixture_error"):
            return await Bridge.reply(send, 429, {"error": {"message": "Provider quota exhausted"}})
        await send({"type": "http.response.start", "status": 200,
                    "headers": [(b"content-type", b"text/event-stream")]})
        for chunk in (b'data: {"type":"response.output_item.added","item":{"type":"function_call","name":"fixture"}}\n\n',
                      b'data: {"type":"response.completed"}\n\n'):
            await send({"type": "http.response.body", "body": chunk, "more_body": True})
            await asyncio.sleep(0)
        await send({"type": "http.response.body", "body": b"", "more_body": False})

    app = Bridge(upstream, KEY, enabled=config["enabled"], status=lambda: github,
                 excel_status=lambda: excel, excel_models=MODELS, refresh_excel=refresh)

    async def request(path="/v1/responses", method="POST", auth=True,
                      body=b'{"model":"fixture-model"}', extra=(), disconnect=False):
        sent = []
        headers = [(b"content-type", b"application/json"), *extra]
        if auth:
            headers.append((b"authorization", ("Bearer " + KEY).encode()))
        scope = {"type": "http", "method": method, "path": path, "headers": headers}
        queue = [{"type": "http.request", "body": body[:11], "more_body": True},
                 {"type": "http.request", "body": body[11:], "more_body": False}]
        if disconnect:
            queue = [{"type": "http.disconnect"}]

        async def receive():
            return queue.pop(0) if queue else {"type": "http.disconnect"}

        async def send(message):
            sent.append(message)

        await app(scope, receive, send)
        return (sent[0]["status"] if sent else None), b"".join(m.get("body", b"") for m in sent), sent

    for prefix in ("", "/excel"):
        assert (await request(prefix + "/v1/responses", auth=False))[0] == 401
        assert (await request(prefix + "/v1/responses", extra=[(b"authorization", b"Bearer wrong")]))[0] == 401
        assert (await request(prefix + "/v1/unknown"))[0] == 404
    for path in ("/responses", "/models", "/chat/completions", "/excel/responses",
                 "/excel/v1/chat/completions", "/excel/v1/messages"):
        assert (await request(path))[0] == 404
    for path in ("/api/config/client-proxy", "/api/config/background-proxy", "/api/config/auto-update"):
        assert (await request(path))[0] == 409
    assert not calls and not refresh_calls
    _, health, _ = await request("/health", "GET", False)
    assert b"never-return-this" not in health
    assert json.loads(health)["backend"] == "copilot+excel"
    if not config["enabled"]:
        for prefix in ("", "/excel"):
            assert (await request(prefix + "/v1/responses"))[0] == 503
        assert not calls and not refresh_calls
        print("DISABLED_OK providers=2 upstream_calls=0")
        return

    for method in ("GET", "POST", "DELETE"):
        assert (await request("/api/config/excel-session", method))[0] == 200
    for copilot_ready in (False, True):
        for excel_ready in (False, True):
            github["authenticated"] = copilot_ready
            excel["configured"] = excel_ready
            for prefix, model, ready in (("", "fixture-model", copilot_ready),
                                         ("/excel", MODELS[0], excel_ready)):
                count = len(calls)
                status, body, _ = await request(prefix + "/v1/responses", body=json.dumps({"model": model}).encode())
                assert status == (200 if ready else 503)
                if not ready:
                    assert b"provider_login_required" in body and len(calls) == count
                # Excel catalog must work with GitHub signed out.
                status, body, _ = await request(prefix + "/v1/models", "GET")
                assert status == (200 if ready else 503)
                if ready:
                    expected = set(MODELS) if prefix else {"fixture-model"}
                    assert {m["id"] for m in json.loads(body)["data"]} == expected
    excel["expired"] = True
    assert (await request("/excel/v1/responses", body=json.dumps({"model": MODELS[0]}).encode()))[0] == 503
    assert (await request())[0] == 200
    excel["expired"] = False
    assert refresh_calls
    count = len(calls)
    for model, prefix in ((MODELS[0], ""), (" GPT-6-ASTRA-EXCEL ", ""),
                          ("fixture-model", "/excel"), ("unknown-excel", "/excel")):
        status, body, _ = await request(prefix + "/v1/responses", body=json.dumps({"model": model}).encode())
        assert status == 400 and b"provider_model_mismatch" in body
    for raw in (b"invalid-json", b"[]", b"{}", b'{"model":5}', b'{"model":" "}'):
        assert (await request(body=raw))[0] == 400
    assert (await request(disconnect=True))[0] is None
    app.MAX_BODY = 5
    assert (await request())[0] == 413
    app.MAX_BODY = Bridge.MAX_BODY
    assert len(calls) == count

    for prefix, model, routes in (("", "fixture-model", Bridge.API_ROUTES),
                                   ("/excel", MODELS[0], Bridge.EXCEL_ROUTES)):
        for method, route in routes:
            if method == "GET":
                continue
            raw = json.dumps({"model": model, "input": [{"role": "user", "content": "verbatim"}],
                              "tools": [{"type": "function", "name": "fixture"}],
                              "reasoning": {"effort": "high"}}).encode()
            status, body, messages = await request(prefix + route, body=raw,
                extra=[(b"cookie", b"private-cookie"), (b"x-api-key", b"private-key"),
                       (b"proxy-authorization", b"private-proxy"), (b"x-request-id", b"request-id")])
            assert status == 200 and b'"response.completed"' in body
            assert calls[-1]["body"] == raw and len(calls[-1]["chunks"]) == 2
            assert calls[-1]["scope"]["path"] == route
            assert calls[-1]["scope"]["raw_path"] == route.encode()
            headers = dict(calls[-1]["scope"]["headers"])
            assert all(k not in headers for k in (b"authorization", b"cookie", b"x-api-key", b"proxy-authorization"))
            assert headers[b"x-request-id"] == b"request-id"
            assert len([m for m in messages if m.get("more_body")]) == 2
        assert (await request(prefix + "/v1/responses", body=json.dumps({"model": model, "fixture_error": True}).encode()))[0] == 429
        await verify_stream(prefix, model)
    print("DUAL_CONTRACT_OK providers=2 independent_login=true catalogs_isolated=true model_guard=true routes=8 body_chunks_preserved=true SSE=true cancellation=true errors=true")


async def verify_stream(prefix, model):
    chunk_seen, cancelled = asyncio.Event(), asyncio.Event()

    async def streaming(scope, receive, send):
        try:
            await send({"type": "http.response.start", "status": 200, "headers": []})
            await send({"type": "http.response.body", "body": b"first-chunk", "more_body": True})
            await asyncio.Event().wait()
        finally:
            cancelled.set()

    async def send(message):
        if message.get("body") == b"first-chunk":
            chunk_seen.set()

    async def receive():
        return {"type": "http.request", "body": json.dumps({"model": model}).encode()}

    live = Bridge(streaming, KEY, status=lambda: {"authenticated": True},
                  excel_status=lambda: {"configured": True}, excel_models=MODELS)
    task = asyncio.create_task(live({"type": "http", "method": "POST", "path": prefix + "/v1/responses",
        "headers": [(b"authorization", ("Bearer " + KEY).encode())]}, receive, send))
    await asyncio.wait_for(chunk_seen.wait(), 2)
    assert not task.done()
    task.cancel()
    try:
        await task
    except asyncio.CancelledError:
        pass
    assert cancelled.is_set()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--config", type=Path, default=Path(__file__).with_name("integration.json"))
    args = parser.parse_args()
    asyncio.run(verify(json.loads(args.config.read_text(encoding="utf-8"))))
