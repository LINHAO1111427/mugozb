"""Create only local, explicitly labelled load-test entities."""
import sys,json,secrets
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from local_api import Client,ROOT

c=Client();c.login()
path=ROOT/'private/performance-fixture.json'
if path.exists():
    print('LOCAL_PERFORMANCE_FIXTURE_EXISTS');raise SystemExit(0)
record={};path.parent.mkdir(exist_ok=True)
def checkpoint():path.write_text(json.dumps(record,indent=2)+'\n',encoding='utf-8')
group=c.request('/api/v1/admin/groups',{'name':'LOCAL PERFORMANCE FIXTURE','platform':'openai','rate_multiplier':1,'subscription_type':'standard'},'POST')
record['group_id']=group['id'];checkpoint()
account=c.request('/api/v1/admin/accounts',{'name':'LOCAL PERFORMANCE FIXTURE','platform':'openai','type':'apikey','credentials':{'api_key':'local-performance-fixture','base_url':'http://perf-upstream:8080/v1'},'extra':{'openai_passthrough':True,'openai_responses_mode':'force_responses'},'concurrency':1024,'priority':1,'group_ids':[group['id']],'upstream_billing_probe_enabled':False},'POST')
record['account_id']=account['id'];checkpoint()
password=secrets.token_urlsafe(24)
user=c.request('/api/v1/admin/users',{'email':'performance-fixture@statekit.local','password':password,'balance':10000,'concurrency':5,'allowed_groups':[group['id']]},'POST')
record.update(user_id=user['id'],password=password);checkpoint()
u=Client();u.token=u.request('/api/v1/auth/login',{'email':'performance-fixture@statekit.local','password':password})['access_token']
key=u.request('/api/v1/keys',{'name':'LOCAL PERFORMANCE FIXTURE','group_id':group['id']},'POST')
record.update(api_key=key['key'],api_key_id=key['id']);checkpoint()
print('LOCAL_PERFORMANCE_FIXTURE_READY '+json.dumps({k:v for k,v in record.items() if k.endswith('_id')}))
