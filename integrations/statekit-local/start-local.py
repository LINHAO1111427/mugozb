"""Start and install STATE Kit locally; leave automatic harvesting off."""
import hashlib, json, subprocess, time, urllib.request, urllib.error
from local_api import Client, ROOT, BASE

def compose(*args):
    subprocess.run(['docker','compose','-f',str(ROOT/'compose.yml'),*args],check=True,cwd=ROOT)
def ready():
    client=Client()
    for attempt in range(90):
        try:
            if client.request('/health')['status']=='ok':return
        except Exception:pass
        time.sleep(1)
    raise RuntimeError('local health check did not become ready')

subprocess.run(['python',str(ROOT/'prepare-local.py')],check=True)
compose('up','-d','--no-build')
ready()
changed=subprocess.run(['docker','compose','-f',str(ROOT/'compose.yml'),'exec','-T','app','sh','-c',
    'if ! grep -q state-kit-release-v1 /app/data/config.yaml; then cat /etc/statekit-trust.yaml >> /app/data/config.yaml; echo TRUST_ADDED; fi'],
    check=True,capture_output=True,text=True).stdout
if 'TRUST_ADDED' in changed:
    compose('restart','app');ready()
client=Client();client.login()
compliance=client.request('/api/v1/admin/compliance')
if compliance.get('required'):
    print('LOCAL_READY '+BASE+'/login')
    print('Administrator acknowledgement pending. Review the document in the local console, then rerun this script.')
    raise SystemExit(3)
plugins=client.request('/api/v1/admin/plugins')
existing=next((p for p in plugins if p['plugin_key']=='io.github.wangyunjeff.sub2api-state-kit'),None)
if not existing:
    package=(ROOT/'statekit.s2plugin').read_bytes()
    assert hashlib.sha256(package).hexdigest()=='e09ac56a13af19f819d3107047f05766401287de853971d406940b68edc6cb5b'
    boundary='StateKitLocalUploadBoundary'
    body=(f'--{boundary}\r\nContent-Disposition: form-data; name="plugin"; filename="statekit.s2plugin"\r\nContent-Type: application/octet-stream\r\n\r\n'.encode()+package+f'\r\n--{boundary}--\r\n'.encode())
    existing=client.request('/api/v1/admin/plugins/upload',body,'POST',{'Content-Type':'multipart/form-data; boundary='+boundary})
    pid=existing['id']
    client.request(f'/api/v1/admin/plugins/{pid}/config',{'enabled':False,'auto_harvest':False,'allow_without_ticket':True,'accounts':[]},'PUT')
pid=existing['id']
if existing['state']!='enabled':
    client.request(f'/api/v1/admin/plugins/{pid}/enable',{'accept_untested':False,'rollout_percent':100},'POST')
plugin=client.request(f'/api/v1/admin/plugins/{pid}')
assert plugin['state']=='enabled' and plugin['runtime_healthy'] and plugin['signature_status']=='trusted'
print('LOCAL_READY '+BASE+'/admin/plugins; plugin='+str(pid)+'; runtime=healthy')
print('Administrator: admin@statekit.local; password is ADMIN_PASSWORD in local .env')
