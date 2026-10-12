"""Run a local-only load stage, capturing exact commands and container statistics."""
import argparse,json,subprocess,sys,time,threading
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('label');p.add_argument('concurrency',type=int);p.add_argument('count',type=int);p.add_argument('--duration',type=int,default=1000);p.add_argument('--cancel',action='store_true');a=p.parse_args()
assert a.label.replace('-','').replace('_','').isalnum()
cmd=['docker','run','--rm','--network','sub2api-statekit-local_default','--mount','type=bind,source='+str(root/'performance')+',target=/bench,readonly','--mount','type=bind,source='+str(root/'private')+',target=/private,readonly','node:24-alpine','node','/bench/load.cjs',str(a.concurrency),str(a.count),str(a.duration)]
if a.cancel:cmd.append('--cancel')
done=threading.Event();samples=[]
fixture=json.loads((root/'private/performance-fixture.json').read_text())
def usage_count():
 r=subprocess.run(['docker','compose','-f',str(root/'compose.yml'),'exec','-T','postgres','psql','-U','statekit','-d','statekit_local','-t','-A','-c','SELECT count(*) FROM usage_logs WHERE user_id='+str(int(fixture['user_id']))+';'],capture_output=True,text=True)
 return int(r.stdout.strip()) if r.returncode==0 else None
before_usage=usage_count()
def stats():
 while not done.is_set():
  r=subprocess.run(['docker','stats','--no-stream','--format','{{json .}}','sub2api-statekit-local-app-1','sub2api-statekit-local-postgres-1','sub2api-statekit-local-redis-1'],capture_output=True,text=True)
  for line in r.stdout.splitlines():
   try:samples.append(json.loads(line))
   except ValueError:pass
  done.wait(1)
t=threading.Thread(target=stats,daemon=True);t.start()
r=subprocess.run(cmd,capture_output=True,text=True,encoding='utf-8');done.set();t.join(timeout=5)
record={'command':cmd,'stdout':r.stdout.strip(),'stderr':r.stderr.strip(),'exit':r.returncode,'container_samples':samples}
try:record['result']=json.loads(r.stdout)
except ValueError:pass
if before_usage is not None and 'result' in record:
 expected=record['result']['success'];after_usage=usage_count()
 for _ in range(20):
  if after_usage is not None and after_usage-before_usage>=expected:break
  time.sleep(.5);after_usage=usage_count()
 record['usage_audit']={'before':before_usage,'after':after_usage,'successful_responses':expected,
 'recorded_delta':after_usage-before_usage if after_usage is not None else None}
out=root/'performance/evidence'/f'{a.label}.json';out.parent.mkdir(exist_ok=True)
out.write_text(json.dumps(record,indent=2)+'\n',encoding='utf-8')
print(r.stdout.strip() or r.stderr.strip());print('USAGE_AUDIT '+json.dumps(record.get('usage_audit')));print('LOAD_EVIDENCE '+str(out))
raise SystemExit(r.returncode)
