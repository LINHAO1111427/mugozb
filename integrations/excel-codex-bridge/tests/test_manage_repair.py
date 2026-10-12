import copy, importlib.util, json
from pathlib import Path
from unittest.mock import patch
import pytest
spec=importlib.util.spec_from_file_location("manage_repair",Path(__file__).resolve().parents[1]/"manage.py")
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

class Admin:
    def __init__(self):
        self.calls=[]
        self.account={"id":41,"name":m.CONFIG["account_name"],"notes":m.CONFIG["marker"],"status":"active","schedulable":False,"credentials":{"base_url":"http://excel-codex-bridge:8000/v1","model_mapping":{"vendor-special":"vendor-special"},"custom_setting":"retain"}}
    def call(self,path,data=None,method=None):
        self.calls.append((path,copy.deepcopy(data),method))
        if path=="/api/v1/admin/accounts/41" and data is None:return copy.deepcopy(self.account)
        return {}

def run(admin,probe):
    with patch.object(m,"_state",return_value={"account_id":41,"group_id":9}),patch.object(m,"_docker_exec",return_value=json.dumps(probe)),patch.object(m,"_save_state"):
        m.repair_existing(admin)

def test_mapping_contains_exact_sol_aliases():
    mapping=m.model_mapping()
    assert mapping["gpt-6.1-sol"]=="gpt-6.1-sol-excel"
    assert mapping["gpt-6-sol"]=="gpt-6-sol-excel"
    assert mapping["gpt-6-sol-excel"]=="gpt-6-sol-excel"

def test_repair_preserves_all_existing_credential_metadata():
    admin=Admin();run(admin,{"http_status":200,"status":"completed"})
    update=next(data for path,data,method in admin.calls if method=="PUT" and "credentials" in (data or {}))
    credentials=update['credentials']
    assert credentials['custom_setting']=='retain'
    assert credentials['model_mapping']['vendor-special']=='vendor-special'
    assert credentials['base_url']=='http://excel-codex-bridge:8000'
    assert any(path.endswith('/schedulable') and data=={'schedulable':True} for path,data,method in admin.calls)

@pytest.mark.parametrize("status",[401,403,429,502])
def test_failed_probe_never_clears_cooldown_or_enables_scheduling(status):
    admin=Admin()
    with pytest.raises(RuntimeError):run(admin,{"http_status":status,"status":None})
    assert not any(any(token in path for token in ('clear-error','clear-rate-limit','temp-unschedulable','schedulable')) for path,data,method in admin.calls)

def test_foreign_account_marker_blocks_mutation():
    admin=Admin();admin.account['notes']='Changed by another integration'
    with pytest.raises(RuntimeError):run(admin,{"http_status":200,"status":"completed"})
    assert not any(method=='PUT' for path,data,method in admin.calls)
