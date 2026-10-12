"""Exercise pinned Excel handlers with fixture credentials and a mock HTTP peer."""
import asyncio
import json
import os
from pathlib import Path
import sys
import tempfile

from bridge import Bridge


async def verify():
    root = Path(__file__).resolve().parent
    config = json.loads((root / "integration.json").read_text(encoding="utf-8"))
    with tempfile.TemporaryDirectory(prefix="ghcp-excel-fixture-") as directory:
        for kind in ("CONFIG", "STATE", "CACHE"):
            os.environ["GHCP_" + kind + "_DIR"] = str(Path(directory) / kind.lower())
        os.environ.update({"GHCP_AUTO_UPDATE": "0", "GHCP_CODEX_NATIVE_INGEST_INTERVAL": "0",
                           "GHCP_COPILOT_SDK_INGEST_INTERVAL": "0"})
        sys.path.insert(0, str((root / config["upstream_dir"]).resolve()))
        import httpx
        import proxy

        store = proxy.excel_upstream.ExcelSessionStore(persistence_file=None)
        store.configure({"authorization": "Bearer fixture-excel-token",
                         "chatgpt-account-id": "fixture-excel-account"}, persist=False)
        proxy.excel_upstream.excel_session_store = store
        # The fixture must neither discover nor read the user's session.
        proxy.excel_session_capture.refresh_macos_excel_session = lambda *a, **k: store.status()
        proxy.excel_session_capture.refresh_windows_excel_session = lambda *a, **k: store.status()
        seen = []

        async def peer(request):
            body = json.loads(request.content)
            assert request.url.path == "/basispoints/api/responses"
            assert request.headers["authorization"] == "Bearer fixture-excel-token"
            assert request.headers["chatgpt-account-id"] == "fixture-excel-account"
            assert body["model"] in proxy.excel_upstream.EXCEL_MODEL_UPSTREAMS.values()
            seen.append(body["model"])
            result = {"id": "resp_excel_fixture", "object": "response", "status": "completed",
                      "model": body["model"], "output": [{"id": "msg_fixture", "type": "message",
                      "role": "assistant", "status": "completed", "content": [
                          {"type": "output_text", "text": "EXCEL_UPSTREAM_FIXTURE_OK", "annotations": []}]}],
                      "usage": {"input_tokens": 1, "output_tokens": 1, "total_tokens": 2}}
            events = [
                {"type": "response.created", "response": {**result, "status": "in_progress", "output": []}},
                {"type": "response.output_text.delta", "delta": "EXCEL_UPSTREAM_FIXTURE_OK"},
                {"type": "response.completed", "response": result},
            ]
            return httpx.Response(200, headers={"content-type": "text/event-stream"},
                content="".join("data: " + json.dumps(e) + "\n\n" for e in events).encode())

        async def unexpected(request):
            raise AssertionError("Excel attempted the Copilot HTTP client")

        async with httpx.AsyncClient(transport=httpx.MockTransport(peer)) as excel_client, \
                   httpx.AsyncClient(transport=httpx.MockTransport(unexpected)) as copilot_client:
            proxy._EXCEL_UPSTREAM_CLIENT = excel_client
            proxy._UPSTREAM_CLIENT = copilot_client
            key = "fixture-key-" + "x" * 40
            app = Bridge(proxy.app, key, status=lambda: {"authenticated": False},
                         excel_status=store.status, excel_models=proxy.excel_upstream.MODEL_IDS)
            async with httpx.AsyncClient(transport=httpx.ASGITransport(app=app), base_url="http://fixture") as client:
                for model in proxy.excel_upstream.MODEL_IDS:
                    for path, stream in (("/excel/v1/responses", False), ("/excel/v1/responses", True),
                                         ("/excel/v1/responses/compact", False)):
                        response = await client.post(path, headers={"Authorization": "Bearer " + key},
                            json={"model": model, "input": [{"role": "user", "content": "fixture"}], "stream": stream})
                        assert response.status_code == 200, (path, response.status_code, response.text[:300])
                        assert "EXCEL_UPSTREAM_FIXTURE_OK" in response.text
                        if not stream:
                            assert response.json()["model"] == model
                        else:
                            assert "response.completed" in response.text
            assert len(seen) == 12
        print("UPSTREAM_EXCEL_OK aliases=4 cases=12 github_signed_out=true mock_http=true real_provider_calls=0")


if __name__ == "__main__":
    asyncio.run(verify())
