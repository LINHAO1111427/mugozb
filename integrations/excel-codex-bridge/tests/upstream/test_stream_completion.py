"""Streams the upstream cuts off, and keepalives while it is silent.

Codex retries a stream that ends without response.completed, with the items
it already finished in the history, and the model then tends to repeat them
word for word: in the app every message shows up twice.
"""

from __future__ import annotations

import asyncio
import json
import unittest

import httpx

from excel_codex_bridge.excel_stream import excel_tool_stream_transform
from excel_codex_bridge.server import create_app
from excel_codex_bridge.sse import iter_sse_messages

from helpers import session_headers
from test_server import StaticReader

SOURCE_BODY = {
    "model": "gpt-5.6-sol-excel",
    "tools": [{"type": "function", "name": "shell_command", "parameters": {"type": "object"}}],
}


def sse(event: str, payload: dict) -> bytes:
    return f"event: {event}\ndata: {json.dumps(payload)}\n\n".encode()


def created(response_id: str = "resp_cut") -> bytes:
    return sse("response.created", {"type": "response.created",
                                     "response": {"id": response_id, "object": "response", "status": "in_progress"}})


def message(index: int, text: str, phase: str) -> list[bytes]:
    item = {"type": "message", "id": f"msg_{index}", "role": "assistant", "phase": phase,
            "status": "in_progress", "content": []}
    done = dict(item, status="completed", content=[{"type": "output_text", "text": text}])
    return [
        sse("response.output_item.added", {"type": "response.output_item.added", "output_index": index, "item": item}),
        sse("response.output_text.delta", {"type": "response.output_text.delta", "item_id": f"msg_{index}",
                                           "output_index": index, "content_index": 0, "delta": text}),
        sse("response.output_text.done", {"type": "response.output_text.done", "item_id": f"msg_{index}",
                                          "output_index": index, "content_index": 0, "text": text}),
        sse("response.output_item.done", {"type": "response.output_item.done", "output_index": index, "item": done}),
    ]


def officejs_call(index: int, command: str) -> list[bytes]:
    """A client tool call the way the add-in's model makes it: through run_officejs."""
    arguments = json.dumps({
        "summary": "Run a command",
        "extended_summary": "Run a command",
        "code": json.dumps({"name": "shell_command", "arguments": {"command": command}}),
        "destructive": False,
        "references": [],
    })
    item = {"type": "function_call", "id": "fc_1", "call_id": "call_1", "name": "run_officejs",
            "status": "in_progress", "arguments": ""}
    done = dict(item, status="completed", arguments=arguments)
    return [
        sse("response.output_item.added", {"type": "response.output_item.added", "output_index": index, "item": item}),
        sse("response.function_call_arguments.delta", {"type": "response.function_call_arguments.delta",
                                                       "output_index": index, "item_id": "fc_1", "delta": arguments}),
        sse("response.function_call_arguments.done", {"type": "response.function_call_arguments.done",
                                                      "output_index": index, "item_id": "fc_1", "arguments": arguments}),
        sse("response.output_item.done", {"type": "response.output_item.done", "output_index": index, "item": done}),
    ]


def completed(output: list[dict]) -> bytes:
    return sse("response.completed", {"type": "response.completed", "response": {
        "id": "resp_cut", "status": "completed", "output": output,
        "usage": {"input_tokens": 5, "output_tokens": 7}}})


async def source(chunks: list[bytes], *, then: Exception | None = None, pause: float = 0.0):
    for chunk in chunks:
        if pause:
            await asyncio.sleep(pause)
        yield chunk
    if then is not None:
        raise then


def parse(raw: bytes) -> list[tuple[str, dict]]:
    events = []
    for block in raw.decode().split("\n\n"):
        if not block.strip():
            continue
        name, data = None, ""
        for line in block.split("\n"):
            if line.startswith("event:"):
                name = line[6:].strip()
            elif line.startswith("data:"):
                data = line[5:].strip()
        events.append((name or "", {} if data == "[DONE]" else json.loads(data)))
    return events


def run(chunks, *, then=None, pause=0.0, keepalive_every=15.0):
    """Output events, and the error the transform ended with (if any)."""
    transform = excel_tool_stream_transform(SOURCE_BODY, keepalive_every=keepalive_every)
    out: list[bytes] = []

    async def go():
        async for chunk in transform(source(chunks, then=then, pause=pause)):
            out.append(chunk)

    error = None
    try:
        asyncio.run(go())
    except Exception as exc:  # noqa: BLE001 - the test inspects it
        error = exc
    return parse(b"".join(out)), error


def cut() -> httpx.RemoteProtocolError:
    return httpx.RemoteProtocolError("peer closed connection without sending complete message body")

