"""Verify the installed local plugin's control API without provider requests."""
import json,time,uuid
from local_api import Client,ROOT

client=Client();client.login()
gate=client.request('/api/v1/admin/compliance')
if gate.get('required'):
    print('ADMIN_ACK_PENDING; no administrator acknowledgement was submitted')
    raise SystemExit(3)
plugins=client.request('/api/v1/admin/plugins')
plugin=next(p for p in plugins if p['plugin_key']=='io.github.wangyunjeff.sub2api-state-kit')
prefix='/api/v1/admin/plugins/'+str(plugin['id'])
assert plugin['runtime_healthy'] and plugin['state']=='enabled'
config=client.request(prefix+'/config')
assert not config.get('accounts'), 'Use a fresh local instance for the empty-account control check'
assert not config.get('enabled') and not config.get('auto_harvest'), 'Expected initial off state'
result={'healthy':True,'trusted':plugin['signature_status']=='trusted'}
for _ in range(40):
    snap=json.loads(client.request(prefix+'/status').get('status_json','{}'))
    if snap.get('resources_ready') and snap.get('actions_ready'):break
    time.sleep(1)
assert snap.get('resources_ready') and snap.get('actions_ready')
result.update(resources_ready=True,actions_ready=True)
action=lambda:client.request(prefix+'/actions',{'kind':'refresh_all','request_id':str(uuid.uuid4())},'POST')
blocked=action()
# The host serializes the protobuf response with omitempty: false is absent.
assert blocked.get('accepted', False) is False
assert blocked.get('message') == '\u8bf7\u5148\u4fdd\u5b58\u5e76\u5f00\u542f\u603b\u5f00\u5173'
result['master_switch_rejects']=True
try:
    modified={**config,'enabled':True,'auto_harvest':False}
    client.request(prefix+'/config',modified,'PUT')
    assert client.request(prefix+'/config')['enabled'] is True
    blocked=action()
    assert blocked.get('accepted', False) is False
    assert blocked.get('message') == '\u6ca1\u6709\u5df2\u5f00\u542f\u4e14\u53ef\u7528\u7684\u8d26\u53f7'
    result['empty_account_rejects']=True
    result['config_save_reload']=True
finally:
    client.request(prefix+'/config',config,'PUT')
assert client.request(prefix+'/config')==config
result['initial_off_state_restored']=True
(ROOT/'evidence/local-api.json').write_text(json.dumps(result,indent=2)+'\n')
print('LOCAL_API_CONTROLS_OK '+json.dumps(result))
