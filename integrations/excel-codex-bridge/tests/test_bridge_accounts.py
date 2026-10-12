import copy
import importlib.util
import json
from pathlib import Path
import sys
import time
from unittest.mock import patch

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
import bridge_accounts as b
sys.path.insert(0, str(Path(__file__).parent / "upstream"))
from helpers import jwt_with_exp


def source(n=53, **claims):
    aid = "fixture-" + str(n)
    token = jwt_with_exp(claims.pop("exp", time.time() + 3600), **{"https://api.openai.com/auth": {"chatgpt_account_id": aid}, **claims})
    return {"id": n, "platform": "openai", "type": "oauth", "credentials": {"access_token": token, "chatgpt_account_id": aid, "metadata": {"keep": True}}}


@pytest.mark.parametrize("source_id", [53, 73, 901])
def test_arbitrary_sources_are_isolated_and_unchanged(source_id, tmp_path, monkeypatch):
    monkeypatch.setattr(b, "RUNTIME", tmp_path)
    value = source(source_id)
    original = copy.deepcopy(value)
    headers = json.loads(b.session_payload(value))["headers"]
    assert value == original
    assert headers["chatgpt-account-id"] == f"fixture-{source_id}"
    bridge = b.AccountBridge(source_id)
    assert bridge.directory == tmp_path / str(source_id)
    assert bridge.container == f"excel-codex-account{source_id}"
    assert "53" not in bridge.marker if source_id != 53 else "53" in bridge.marker


@pytest.mark.parametrize("invalid", ["identity", "expiry", "type", "token"])
def test_bad_source_is_rejected_without_persistence(invalid):
    value = source()
    if invalid == "identity": value["credentials"]["chatgpt_account_id"] = "other"
    if invalid == "expiry": value = source(exp=time.time() - 1)
    if invalid == "type": value["type"] = "apikey"
    if invalid == "token": value["credentials"]["access_token"] = "broken"
    with pytest.raises(RuntimeError): b.session_payload(value)


class Admin:
    def __init__(self, bridge):
        self.bridge, self.writes = bridge, []

    def call(self, path, data=None, method=None):
        if data is not None or method is not None:
            self.writes.append((path, data, method))
            return {}
        return {"id": 154, "notes": self.bridge.marker, "credentials": {"base_url": self.bridge.base_url}}


@pytest.mark.parametrize("result", [
    {"http_status": 429}, {"http_status": 401},
    {"http_status": 200, "status": "failed"},
    {"http_status": 200, "status": "completed", "model": "gpt-5.6-luna", "text": "BRIDGE_ACCOUNT_OK"},
    {"http_status": 200, "status": "completed", "model": None, "text": "BRIDGE_ACCOUNT_OK"},
])
def test_failed_probe_cannot_activate_any_source(tmp_path, monkeypatch, result):
    monkeypatch.setattr(b, "RUNTIME", tmp_path)
    bridge = b.AccountBridge(73)
    bridge.admin = Admin(bridge)
    bridge.save({"account_id": 154})
    monkeypatch.setattr(bridge, "probe", lambda model: result)
    with pytest.raises(RuntimeError): bridge.activate("gpt-6-sol-excel")
    assert bridge.admin.writes == []


def test_activation_touches_only_new_bridge_account(tmp_path, monkeypatch):
    monkeypatch.setattr(b, "RUNTIME", tmp_path)
    bridge = b.AccountBridge(73)
    bridge.admin = Admin(bridge)
    bridge.save({"account_id": 154})
    monkeypatch.setattr(bridge, "probe", lambda model: {"http_status": 200, "status": "completed", "model": "gpt-6-sol", "text": "BRIDGE_ACCOUNT_OK"})
    monkeypatch.setattr(bridge, "status", lambda: {})
    bridge.activate("gpt-6-sol-excel")
    assert len(bridge.admin.writes) == 2
    assert all(path.startswith("/api/v1/admin/accounts/154") for path, _, _ in bridge.admin.writes)
    assert not any("credentials" in data for _, data, _ in bridge.admin.writes)


def test_model_map_is_shared_catalog():
    assert b.mapping()["gpt-6.1-sol"] == "gpt-6.1-sol-excel"
    assert b.mapping()["gpt-6-astra-1m"] == "gpt-6-astra-1m-excel"


def test_remove_only_targets_managed_bridge(tmp_path, monkeypatch):
    monkeypatch.setattr(b, "RUNTIME", tmp_path)
    bridge = b.AccountBridge(73)
    bridge.admin = Admin(bridge)
    bridge.save({"account_id": 154})
    monkeypatch.setattr(bridge, "inspect", lambda: {"Id": "fixture"})
    commands = []
    monkeypatch.setattr(b, "run", lambda args: commands.append(args))
    result = bridge.remove()
    assert result["removed_account_id"] == 154
    assert commands == [["docker", "rm", "-f", "excel-codex-account73"]]
    assert any(path.endswith("/154") and method == "DELETE" for path, _, method in bridge.admin.writes)
    assert "account_id" not in bridge.state()


def test_remove_refuses_source_account_even_with_corrupted_state(tmp_path, monkeypatch):
    monkeypatch.setattr(b, "RUNTIME", tmp_path)
    bridge = b.AccountBridge(73)
    bridge.admin = Admin(bridge)
    bridge.save({"account_id": 73})
    with pytest.raises(RuntimeError): bridge.remove()
    assert bridge.admin.writes == []
