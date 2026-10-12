"""Verify proxy-config restoration on a private copy; retain the live proxy."""
import hashlib,json
from local_api import Client,ROOT

digest=lambda value:hashlib.sha256(json.dumps(value,sort_keys=True).encode()).hexdigest()
client=Client();client.login()
prefix='/api/v1/admin/plugins/1/config'
modified=client.request(prefix)
original=json.loads((ROOT/'private/config-before-proxy.json').read_text(encoding='utf-8'))
assert modified.get('dynamic_proxy_url'), 'Expected the configured local proxy'
copy_path=ROOT/'private/config-proxy-rollback-copy.json'
copy_path.write_text(json.dumps(modified,indent=2)+'\n',encoding='utf-8')
copy=json.loads(copy_path.read_text(encoding='utf-8'))
if 'dynamic_proxy_url' in original:copy['dynamic_proxy_url']=original['dynamic_proxy_url']
else:copy.pop('dynamic_proxy_url',None)
copy_path.write_text(json.dumps(copy,indent=2)+'\n',encoding='utf-8')
assert json.loads(copy_path.read_text(encoding='utf-8'))==original
assert client.request(prefix)==modified, 'Live configuration changed during the copy check'
result={'changed_field':'dynamic_proxy_url','original_sha256':digest(original),
    'modified_sha256':digest(modified),'restored_copy_sha256':digest(copy),
    'copy_restored':True,'live_proxy_retained':True}
(ROOT/'evidence/proxy-config-rollback.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print('PROXY_ROLLBACK_COPY_OK field=dynamic_proxy_url restored=true live_proxy_retained=true')
