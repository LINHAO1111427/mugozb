"""Launch GHCP with isolated state and the Sub2API API boundary."""
import asyncio
from contextlib import asynccontextmanager
import json
import os
from pathlib import Path
import sys

from bridge import Bridge

ROOT = Path(__file__).resolve().parent
CONFIG = json.loads((ROOT / "integration.json").read_text(encoding="utf-8"))
RUNTIME = ROOT / ".runtime"


def main():
    if CONFIG["backend"] != "copilot+excel" or CONFIG["listen_host"] != "127.0.0.1":
        raise ValueError("This installation uses Copilot and Excel on loopback")
    for kind in ("CONFIG", "STATE", "CACHE"):
        path = RUNTIME / kind.lower()
        path.mkdir(parents=True, exist_ok=True)
        os.environ["GHCP_" + kind + "_DIR"] = str(path)
    os.environ.update({"GHCP_AUTO_UPDATE": "0", "GHCP_CODEX_NATIVE_INGEST_INTERVAL": "0",
                       "GHCP_COPILOT_SDK_INGEST_INTERVAL": "0"})
    sys.path.insert(0, str((ROOT / CONFIG["upstream_dir"]).resolve()))
    import proxy
    import uvicorn

    async def refresh_excel():
        for refresh in (proxy.excel_session_capture.refresh_macos_excel_session,
                        proxy.excel_session_capture.refresh_windows_excel_session):
            await asyncio.to_thread(refresh, proxy.excel_upstream.excel_session_store)

    @asynccontextmanager
    async def lifespan(app):
        # Original startup also rewrites clients and starts automatic updates.
        proxy.excel_upstream.excel_session_store.load()
        await refresh_excel()
        try:
            yield
        finally:
            await proxy.copilot_sdk_upstream.shutdown()
            for client in (proxy._UPSTREAM_CLIENT, proxy._EXCEL_UPSTREAM_CLIENT):
                if client is not None:
                    await client.aclose()

    proxy.app.router.lifespan_context = lifespan
    app = Bridge(proxy.app, (RUNTIME / "bridge-key").read_text().strip(),
                 enabled=CONFIG["enabled"], status=proxy.auth.auth_status,
                 excel_status=proxy.excel_upstream.excel_session_store.status,
                 excel_models=proxy.excel_upstream.MODEL_IDS, refresh_excel=refresh_excel)
    uvicorn.run(app, host=CONFIG["listen_host"], port=CONFIG["listen_port"],
                access_log=False, timeout_graceful_shutdown=5)


if __name__ == "__main__":
    main()
