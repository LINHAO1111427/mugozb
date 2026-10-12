"""Authenticated, provider-isolated ASGI boundary for the pinned GHCP app."""
from collections import deque
import hmac
import json


class Bridge:
    API_ROUTES = {
        ("GET", "/v1/models"),
        ("POST", "/v1/responses"),
        ("POST", "/v1/responses/compact"),
        ("POST", "/v1/chat/completions"),
        ("POST", "/v1/messages"),
    }
    EXCEL_ROUTES = API_ROUTES - {
        ("POST", "/v1/chat/completions"), ("POST", "/v1/messages"),
    }
    ALIASES = {"/models", "/responses", "/responses/compact", "/chat/completions"}
    MAX_BODY = 32 * 1024 * 1024

    def __init__(self, app, key, *, enabled=True, status=None, excel_status=None,
                 excel_models=(), refresh_excel=None):
        if not isinstance(key, str) or len(key) < 32:
            raise ValueError("An integration key of at least 32 characters is required")
        self.app, self.key, self.enabled = app, key.encode(), enabled
        self.status = status or (lambda: {"authenticated": False})
        self.excel_status = excel_status or (lambda: {"configured": False})
        self.excel_models = frozenset(excel_models)
        self.refresh_excel = refresh_excel

    def providers(self):
        excel = self.excel_status()
        return {
            "copilot": {"ready": bool(self.status().get("authenticated"))},
            "excel": {"ready": bool(excel.get("configured") and not excel.get("expired")),
                      "configured": bool(excel.get("configured")),
                      "expired": bool(excel.get("expired"))},
        }

    @staticmethod
    async def reply(send, status, value):
        body = json.dumps(value).encode()
        await send({"type": "http.response.start", "status": status, "headers": [
            (b"content-type", b"application/json"), (b"cache-control", b"no-store"),
            (b"content-length", str(len(body)).encode())]})
        await send({"type": "http.response.body", "body": body})

    async def copilot_models(self, scope, receive, send):
        # Upstream merges Excel aliases into its Copilot catalog. Filter only
        # the small JSON model list; inference responses stream untouched.
        messages = []

        async def collect(message):
            messages.append(message)

        await self.app(scope, receive, collect)
        start = next(m for m in messages if m["type"] == "http.response.start")
        if start["status"] == 200:
            raw = b"".join(m.get("body", b"") for m in messages)
            try:
                payload = json.loads(raw)
                payload["data"] = [m for m in payload["data"]
                                   if not str(m.get("id", "")).strip().lower().endswith("-excel")]
            except (ValueError, KeyError, TypeError, AttributeError):
                return await self.reply(send, 502, {"error": {"message": "Invalid upstream model catalog"}})
            return await self.reply(send, 200, payload)
        for message in messages:
            await send(message)

    async def __call__(self, scope, receive, send):
        if scope["type"] == "lifespan":
            return await self.app(scope, receive, send)
        if scope["type"] == "websocket":
            return await send({"type": "websocket.close", "code": 1008})
        path, method = scope["path"], scope["method"]
        if path == "/health" and method == "GET":
            providers = self.providers()
            return await self.reply(send, 200, {
                "service": "sub2api-ghcp", "enabled": self.enabled,
                "backend": "copilot+excel", "providers": providers,
                "authenticated": providers["copilot"]["ready"],
            })
        if path in self.ALIASES or path.startswith(("/v1", "/excel")):
            provider = "excel" if path.startswith("/excel/") else "copilot"
            route = path.removeprefix("/excel") if provider == "excel" else path
            allowed = self.EXCEL_ROUTES if provider == "excel" else self.API_ROUTES
            if (method, route) not in allowed:
                return await self.reply(send, 404, {"error": {"message": "Unknown API route"}})
            headers = scope.get("headers", [])
            auth = [v for k, v in headers if k.lower() == b"authorization"]
            if len(auth) != 1 or not hmac.compare_digest(auth[0], b"Bearer " + self.key):
                return await self.reply(send, 401, {"error": {
                    "type": "authentication_error", "message": "Invalid integration key"}})
            if not self.enabled:
                return await self.reply(send, 503, {"error": {"message": "GHCP integration disabled"}})
            if method == "POST":
                chunks, size = deque(), 0
                while True:
                    message = await receive()
                    if message["type"] == "http.disconnect":
                        return
                    chunks.append(message)
                    size += len(message.get("body", b""))
                    if size > self.MAX_BODY:
                        return await self.reply(send, 413, {"error": {"message": "Request exceeds 32 MiB"}})
                    if not message.get("more_body"):
                        break
                try:
                    payload = json.loads(b"".join(m.get("body", b"") for m in chunks))
                    model = payload.get("model") if isinstance(payload, dict) else None
                    if not isinstance(model, str) or not model.strip():
                        raise ValueError("Missing model")
                except (ValueError, UnicodeError):
                    return await self.reply(send, 400, {"error": {"message": "A JSON object with model is required"}})
                normalized = model.strip().lower()
                if (provider == "excel" and normalized not in self.excel_models) or (
                    provider == "copilot" and normalized.endswith("-excel")
                ):
                    return await self.reply(send, 400, {"error": {
                        "code": "provider_model_mismatch", "message": "Model does not belong to this provider route"}})
                original_receive = receive

                async def replay():
                    return chunks.popleft() if chunks else await original_receive()

                receive = replay
            if provider == "excel" and self.refresh_excel:
                await self.refresh_excel()
            if not self.providers()[provider]["ready"]:
                instructions = ("Sign in to GitHub Copilot at /ui" if provider == "copilot" else
                                "Open the official ChatGPT task pane in Excel and sign in; then read its cached session at /ui")
                return await self.reply(send, 503, {"error": {
                    "code": "provider_login_required", "provider": provider, "message": instructions}})
            if method == "GET" and provider == "excel":
                return await self.reply(send, 200, {"object": "list", "data": [
                    {"id": m, "object": "model", "created": 0, "owned_by": "openai-excel"}
                    for m in sorted(self.excel_models)]})
            scope = dict(scope, path=route, raw_path=route.encode())
            scope["headers"] = [(k, v) for k, v in headers if k.lower() not in {
                b"authorization", b"x-api-key", b"cookie", b"proxy-authorization"}]
            if method == "GET":
                return await self.copilot_models(scope, receive, send)
        # Dashboard owns provider login/session controls; Sub2API owns clients.
        if method != "GET" and path in {
            "/api/config/client-proxy", "/api/config/background-proxy", "/api/config/auto-update",
        }:
            return await self.reply(send, 409, {"error": "Managed by the Sub2API integration"})
        return await self.app(scope, receive, send)
