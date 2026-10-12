import asyncio, json, sys
from datetime import datetime, timedelta, timezone
from email.utils import format_datetime
from pathlib import Path
from unittest.mock import AsyncMock, patch
import httpx
import pytest
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(Path(__file__).resolve().parent / "upstream"))
from test_server import BridgeHarness, sse, text_stream
from excel_codex_bridge import server

def completed(_):
    return httpx.Response(200,headers={"content-type":"text/event-stream"},content=text_stream("ok", json.loads(_.content)["model"]))

def fail(code="rate_limit_exceeded",message="Try again in 1ms"):
    return sse("response.failed",{"type":"response.failed","response":{"id":"r","status":"failed","error":{"code":code,"message":message}}})

def request(h,stream=False,model="gpt-6.1-sol"):
    with patch.object(server.asyncio,"sleep",new=AsyncMock()):
        return h.request("POST","/v1/responses",json={"model":model,"input":"ping","stream":stream})

@pytest.mark.parametrize("stream",[False,True])
@pytest.mark.parametrize("model",["gpt-6.1-sol","gpt-6.1-sol-excel","gpt-6-sol","gpt-6-sol-excel"])
def test_exact_sol_upstream(stream,model):
    h=BridgeHarness(completed);r=request(h,stream,model)
    assert r.status_code==200
    assert h.upstream_json()["model"]==model.removesuffix("-excel")

@pytest.mark.parametrize("status",[408,425,429,500,502,503,504])
@pytest.mark.parametrize("stream",[False,True])
def test_transient_status_recovers_with_one_retry(status,stream):
    calls=[]
    def handler(req):
        calls.append(req)
        return httpx.Response(status,text="transient") if len(calls)==1 else completed(req)
    h=BridgeHarness(handler);r=request(h,stream)
    assert r.status_code==200
    assert len(calls)==2

@pytest.mark.parametrize("stream",[False,True])
def test_transient_http_cap_is_three_requests(stream):
    h=BridgeHarness(lambda _:httpx.Response(503,text="still unavailable"))
    assert request(h,stream).status_code==503
    assert len(h.upstream_requests)==3

@pytest.mark.parametrize("stream",[False,True])
@pytest.mark.parametrize("retry_after",["60",format_datetime(datetime.now(timezone.utc)+timedelta(days=1)),"Infinity"])
def test_long_retry_after_is_preserved_without_retry(stream,retry_after):
    h=BridgeHarness(lambda _:httpx.Response(429,headers={"retry-after":retry_after},text="wait"))
    r=request(h,stream)
    assert r.status_code==429 and r.headers["retry-after"]==retry_after
    assert len(h.upstream_requests)==1

@pytest.mark.parametrize("stream",[False,True])
@pytest.mark.parametrize("status",[400,401,403,404])
def test_permanent_failures_are_not_retried(stream,status):
    h=BridgeHarness(lambda _:httpx.Response(status,text="permanent"))
    assert request(h,stream).status_code==status
    assert len(h.upstream_requests)==1

@pytest.mark.parametrize("stream",[False,True])
def test_http_and_sse_share_one_budget(stream):
    calls=[]
    def handler(req):
        calls.append(req)
        if len(calls)==1:return httpx.Response(503,text="unavailable")
        return httpx.Response(200,headers={"content-type":"text/event-stream"},content=fail())
    h=BridgeHarness(handler);r=request(h,stream)
    assert len(calls)==3
    assert "rate_limit_exceeded" in r.text and "invalid_prompt" not in r.text
    assert r.status_code==(200 if stream else 429)

@pytest.mark.parametrize("stream",[False,True])
def test_no_retry_after_output(stream):
    content=sse("response.output_text.delta",{"type":"response.output_text.delta","delta":"partial"})+fail()
    h=BridgeHarness(lambda _:httpx.Response(200,headers={"content-type":"text/event-stream"},content=content))
    r=request(h,stream)
    assert len(h.upstream_requests)==1 and "rate_limit_exceeded" in r.text

def test_nonstream_failed_event_keeps_provider_error():
    h=BridgeHarness(lambda _:httpx.Response(200,headers={"content-type":"text/event-stream"},content=fail("quota_exhausted","quota exhausted")))
    r=request(h)
    assert r.status_code==502 and r.json()["error"]["code"]=="quota_exhausted"
    assert len(h.upstream_requests)==1

@pytest.mark.parametrize("stream",[False,True])
def test_model_permission_error_does_not_look_like_bad_credentials(stream):
    message="Model access has changed. Available models will update automatically."
    h=BridgeHarness(lambda _:httpx.Response(403,json={"error":{"message":message}}))
    r=request(h,stream)
    assert r.status_code==400
    assert r.json()["error"]=={"type":"invalid_request_error","code":"model_not_supported","param":"model","message":message,"upstream_status":403}
    assert len(h.upstream_requests)==1
