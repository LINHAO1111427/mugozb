"""Inspect/apply/restore explicit local user and account concurrency quotas."""
import argparse,json,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from local_api import Client,ROOT

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--user-id',type=int,action='append',default=[])
p.add_argument('--account-id',type=int,action='append',default=[])
p.add_argument('--limit',type=int)
p.add_argument('--apply',action='store_true')
p.add_argument('--snapshot',type=Path,required=True)
p.add_argument('--rollback',action='store_true')
a=p.parse_args();c=Client();c.login()
if a.rollback:
    record=json.loads(a.snapshot.read_text())
    # Validate all targets before any mutation; preserve newer administrator edits.
    for r in record:
        live=c.request(r['path'])
        assert live['id']==r['id'] and live['concurrency']==r['after'], 'Quota changed since this snapshot'
    for r in record:
        c.request(r['path'],{'concurrency':r['before']},'PUT')
        assert c.request(r['path'])['concurrency']==r['before']
    print('QUOTA_ROLLBACK_OK targets='+str(len(record)));raise SystemExit(0)
assert a.limit is not None and 1<=a.limit<=2048, 'Choose a bounded tested limit (1..2048)'
targets=[('users',i) for i in a.user_id]+[('accounts',i) for i in a.account_id]
assert targets and len(set(targets))==len(targets)
record=[]
for kind,id in targets:
    path='/api/v1/admin/'+kind+'/'+str(id);v=c.request(path)
    record.append({'path':path,'id':id,'before':v['concurrency'],'after':a.limit})
print(json.dumps(record))
if a.apply:
    assert not a.snapshot.exists(), 'Use a new snapshot path; preserve prior rollback evidence'
    a.snapshot.parent.mkdir(parents=True,exist_ok=True)
    a.snapshot.write_text(json.dumps(record,indent=2)+'\n')
    for r in record:
        assert c.request(r['path'])['concurrency']==r['before'], 'Concurrent administrator edit'
        c.request(r['path'],{'concurrency':r['after']},'PUT')
        assert c.request(r['path'])['concurrency']==r['after']
    print('QUOTA_APPLIED targets='+str(len(record))+' limit='+str(a.limit))
else:print('QUOTA_PREVIEW_ONLY')
