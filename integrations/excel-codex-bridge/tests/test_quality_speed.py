"""Offline request/response contracts; no provider calls or credentials."""
import asyncio
import importlib.util
import json
import os
from pathlib import Path
import sys
import time
from unittest.mock import AsyncMock, patch

import httpx
import pytest

from excel_codex_bridge import server
from excel_codex_bridge import sse, images

MODEL = "gpt-6-sol"
TOOLS = [{"type": "function", "name": "lookup", "parameters": {"type": "object"}}]


class Reader:
    source = "codex"
    last_error = None

    def __init__(self):
        self.store = self

    def refresh(self):
        return None

    def request_headers(self, **kwargs):
        return {"authorization": "Bearer fixture-only", "chatgpt-account-id": "fixture"}

    def tools_version_id(self):
        return None

    def fall_back(self, used):
        return False

    def hint(self):
        return "fixture"


def payload(model=MODEL, status="completed", **fields):
    return {"id": "r", "model": model, "status": status, "output": [], **fields}


def event(kind="response.completed", **fields):
    return sse.sse_encode(kind, {"type": kind, "response": payload(**fields)})


class TailStream(httpx.AsyncByteStream):
    def __init__(self, data, *, split=False):
        self.data, self.split = data, split
        self.tail_reads = 0
        self.closed = False

    async def __aiter__(self):
        if self.split:
            for byte in self.data:
                yield bytes([byte])
        else:
            yield self.data
        self.tail_reads += 1
        await asyncio.sleep(0.12)

    async def aclose(self):
        self.closed = True


async def call(handler, *, stream=False, tools=False, body=None, configure=None):
    calls = []

    async def send(req):
        calls.append(req)
        return handler(req)

    bridge = server.Bridge(Reader(), lambda: httpx.AsyncClient(transport=httpx.MockTransport(send)))
    if configure:
        configure(bridge)
    try:
        response = await bridge.responses(body or {
            "model": MODEL, "input": "ping", "stream": stream,
            **({"tools": TOOLS} if tools else {}),
        })
        if hasattr(response, "body_iterator"):
            raw = b"".join([chunk async for chunk in response.body_iterator])
        else:
            raw = bytes(response.body)
        return response.status_code, raw, calls
    finally:
        await bridge.aclose()


def serve(data):
    return lambda _: httpx.Response(200, headers={"content-type": "text/event-stream"}, stream=data)


@pytest.mark.parametrize("stream,tools", [(False, False), (True, False), (True, True)])
@pytest.mark.parametrize("kind", ["response.completed", "response.failed", "response.incomplete"])
@pytest.mark.parametrize("split", [False, True])
def test_terminal_does_not_wait_for_eof(stream, tools, kind, split):
    data = TailStream(event(kind, status=kind.split(".")[1], error={"code": "fixture"} if kind.endswith("failed") else None), split=split)
    asyncio.run(call(serve(data), stream=stream, tools=tools))
    assert data.tail_reads == 0
    assert data.closed


@pytest.mark.parametrize("stream,tools", [(False, False), (True, False), (True, True)])
@pytest.mark.parametrize("actual", ["gpt-5.6-luna", "unlisted-model"])
def test_model_mismatch_cannot_complete(stream, tools, actual):
    data = TailStream(event(model=actual))
    status, raw, calls = asyncio.run(call(serve(data), stream=stream, tools=tools))
    assert b"upstream_model_mismatch" in raw
    assert b"response.completed" not in raw
    assert status == (200 if stream else 502)
    assert len(calls) == 1
    assert data.closed


@pytest.mark.parametrize("model", [MODEL, MODEL + "-excel", MODEL + "-1m-excel"])
def test_aliases_keep_matching_model(model):
    status, raw, _ = asyncio.run(call(lambda _: httpx.Response(200, json=payload()), body={"model": model, "input": "ping"}))
    assert status == 200
    assert json.loads(raw)["model"] == MODEL


def test_missing_model_is_not_invented():
    response = payload()
    response.pop("model")
    status, raw, _ = asyncio.run(call(lambda _: httpx.Response(200, json=response)))
    assert status == 200
    assert "model" not in json.loads(raw)


def test_incomplete_json_is_not_success():
    status, raw, _ = asyncio.run(call(lambda _: httpx.Response(200, json=payload(status="incomplete", incomplete_details={"reason": "max_output_tokens"}))))
    assert status == 502
    assert json.loads(raw)["error"]["code"] == "upstream_incomplete"


IMAGE_BODY = {"model": MODEL, "input": [{"role": "user", "content": [
    {"type": "input_text", "text": "Read this picture"},
    {"type": "input_image", "image_url": "data:image/png;base64,eA=="},
]}]}


@pytest.mark.parametrize("stream", [False, True])
def test_upload_failure_does_not_send_request_without_image(stream):
    def handler(req):
        if str(req.url).endswith("/attachments"):
            return httpx.Response(400, json={"error": {"message": "fixture upload rejected"}})
        return httpx.Response(200, json=payload())
    status, raw, calls = asyncio.run(call(handler, body={**IMAGE_BODY, "stream": stream}, configure=lambda bridge: bridge.pictures.refuse_inline("message")))
    assert status == 422
    assert json.loads(raw)["error"]["code"] == "image_input_unavailable"
    assert len(calls) == 1
    assert str(calls[0].url).endswith("/attachments")


def test_uploaded_image_refused_does_not_drop_it_and_retry():
    sent = []
    def handler(req):
        if str(req.url).endswith("/attachments"):
            return httpx.Response(200, json={"openai_file_id": "fixture-file"})
        sent.append(json.loads(req.content))
        return httpx.Response(422, json={"error": {"message": "image not supported"}})
    status, _, _ = asyncio.run(call(handler, body=IMAGE_BODY))
    assert status == 422
    assert len(sent) == 2  # inline, then uploaded; never without the image


def test_successful_image_upload_still_works():
    sent = []
    def handler(req):
        if str(req.url).endswith("/attachments"):
            return httpx.Response(200, json={"openai_file_id": "fixture-file"})
        sent.append(json.loads(req.content))
        if len(sent) == 1:
            return httpx.Response(422, json={"error": {"message": "inline refused"}})
        return httpx.Response(200, json=payload())
    status, _, _ = asyncio.run(call(handler, body=IMAGE_BODY))
    assert status == 200
    assert "fixture-file" in json.dumps(sent[1])


def test_mismatch_during_opening_hides_later_text():
    data = TailStream(event("response.created", model="gpt-5.6-luna") + sse.sse_encode("response.output_text.delta", {"delta": "wrong answer"}) + event())
    _, raw, _ = asyncio.run(call(serve(data), stream=True))
    assert b"wrong answer" not in raw
    assert b"upstream_model_mismatch" in raw


def test_stream_disconnect_closes_upstream():
    async def run():
        data = TailStream(sse.sse_encode("response.output_text.delta", {"delta": "hello"}) + event())
        bridge = server.Bridge(Reader(), lambda: httpx.AsyncClient(transport=httpx.MockTransport(serve(data))))
        try:
            response = await bridge.responses({"model": MODEL, "input": "ping", "stream": True})
            assert b"hello" in await anext(response.body_iterator)
            await response.body_iterator.aclose()
            assert data.closed
        finally:
            await bridge.aclose()
    asyncio.run(run())


@pytest.mark.parametrize("tools", [False, True])
def test_finished_item_without_terminal_never_becomes_completed(tools):
    item = {"id": "msg", "type": "message", "role": "assistant", "status": "completed",
            "content": [{"type": "output_text", "text": "partial"}]}
    data = TailStream(sse.sse_encode("response.output_item.done", {"type": "response.output_item.done", "item": item, "output_index": 0}))
    _, raw, _ = asyncio.run(call(serve(data), stream=True, tools=tools))
    assert b"response.completed" not in raw
    assert b"upstream_incomplete" in raw


@pytest.mark.parametrize("effort", ["low", "medium", "high", "xhigh", "extra-high"])
def test_supported_effort_is_not_lowered(effort):
    status, _, calls = asyncio.run(call(lambda _: httpx.Response(200, json=payload()), body={"model": MODEL, "input": "ping", "reasoning": {"effort": effort}}))
    assert status == 200
    assert json.loads(calls[0].content)["reasoning_effort"] == ("xhigh" if effort == "extra-high" else effort)


@pytest.mark.parametrize("effort", ["ultra", "max", "typo", 42, ""])
@pytest.mark.parametrize("field", ["reasoning", "reasoning_effort"])
def test_unsupported_effort_is_not_silently_medium(effort, field):
    status, raw, calls = asyncio.run(call(lambda _: httpx.Response(200, json=payload()), body={"model": MODEL, "input": "ping", field: {"effort": effort} if field == "reasoning" else effort}))
    assert status == 400
    assert json.loads(raw)["error"]["code"] == "unsupported_reasoning_effort"
    assert calls == []


async def observe():
    report = {}
    for stream, tools in [(False, False), (True, False), (True, True)]:
        data = TailStream(event())
        started = time.perf_counter()
        status, raw, _ = await call(serve(data), stream=stream, tools=tools)
        report[f"terminal_stream={stream}_tools={tools}"] = {"http": status, "tail_reads": data.tail_reads, "closed": data.closed, "elapsed_ms": round(1000 * (time.perf_counter() - started), 2)}
    status, raw, _ = await call(lambda _: httpx.Response(200, json=payload(model="gpt-5.6-luna")))
    report["mismatch"] = {"http": status, "body": json.loads(raw)}
    def handler(req):
        return httpx.Response(400, json={"error": {"message": "fixture upload rejected"}}) if str(req.url).endswith("/attachments") else httpx.Response(200, json=payload())
    status, raw, calls = await call(handler, body=IMAGE_BODY, configure=lambda bridge: bridge.pictures.refuse_inline("message"))
    report["image_failure"] = {"http": status, "request_count": len(calls), "body": json.loads(raw)}
    status, raw, calls = await call(lambda _: httpx.Response(200, json=payload()), body={"model": MODEL, "input": "ping", "reasoning": {"effort": "ultra"}})
    report["unsupported_effort"] = {"http": status, "upstream_effort": json.loads(calls[0].content)["reasoning_effort"] if calls else None, "body": json.loads(raw)}
    print(json.dumps(report, ensure_ascii=True, sort_keys=True))


if __name__ == "__main__":
    asyncio.run(observe())
