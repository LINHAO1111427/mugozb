"""Apply the local STATEKIT_PROXY_URL, then check its exit through STATE Kit."""
import hashlib,json,time,uuid
from urllib.parse import urlsplit
from local_api import Client,ROOT

env=dict(line.split('=',1) for line in (ROOT/'.env').read_text().splitlines() if '=' in line)
proxy=env['STATEKIT_PROXY_URL']
url=urlsplit(proxy)
assert url.scheme in ('socks5','socks5h','http','https') and url.hostname and url.port
client=Client();client.login()
plugin=next(p for p in client.request('/api/v1/admin/plugins') if p['plugin_key']=='io.github.wangyunjeff.sub2api-state-kit')
prefix='/api/v1/admin/plugins/'+str(plugin['id'])
before=client.request(prefix+'/config')
assert not before.get('enabled') and not before.get('auto_harvest') and not before.get('accounts'), 'Proxy setup expects the disabled local fixture'
assert not before.get('dynamic_proxy_url') or before['dynamic_proxy_url']==proxy, 'Existing proxy differs; preserve it for review'
private=ROOT/'private';private.mkdir(exist_ok=True)
backup=private/'config-before-proxy.json'
if not backup.exists():backup.write_text(json.dumps(before,indent=2)+'\n',encoding='utf-8')
after={**before,'dynamic_proxy_url':proxy}
client.request(prefix+'/config',after,'PUT')
assert client.request(prefix+'/config')==after
request_id=str(uuid.uuid4())
action={'kind':'proxy_test','request_id':request_id,'proxy':{
    'dynamic_proxy_url':proxy,'harvest_dial_proxy_mode':after.get('harvest_dial_proxy_mode','direct'),
    'harvest_dial_proxy_id':after.get('harvest_dial_proxy_id',0),'harvest_dial_proxy_url':after.get('harvest_dial_proxy_url','')}}
accepted=client.request(prefix+'/actions',action,'POST')
assert accepted.get('accepted'), 'Plugin proxy check was rejected'
manual={}
for _ in range(55):
    status=json.loads(client.request(prefix+'/status').get('status_json','{}'))
    manual=status.get('manual_test') or {}
    if manual.get('id')==request_id and not manual.get('running'):break
    time.sleep(1)
else:
    client.request(prefix+'/actions',{'kind':'cancel_test','request_id':str(uuid.uuid4())},'POST')
    raise SystemExit('Proxy check timed out; cancellation requested')
result={
    'proxy_configured':True,'proxy_host':url.hostname,'proxy_port':url.port,
    'changed_field':'dynamic_proxy_url','check_accepted':True,
    'exit_ip':manual.get('exit_ip'),'country_code':manual.get('country_code'),
    'complete':manual.get('complete'),'ip_error':manual.get('ip_error'),
    'error':manual.get('error'),'duration_ms':manual.get('duration_ms'),
    'harvesting_enabled':False,'accounts_count':0,
    'before_sha256':hashlib.sha256(json.dumps(before,sort_keys=True).encode()).hexdigest(),
    'after_sha256':hashlib.sha256(json.dumps(after,sort_keys=True).encode()).hexdigest()}
(ROOT/'evidence/local-proxy.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
if not (result['complete'] and result['exit_ip'] and not result['error']):
    print('LOCAL_PROXY_CHECK_FAILED '+json.dumps(result))
    raise SystemExit(1)
print('LOCAL_PROXY_OK '+json.dumps(result))
