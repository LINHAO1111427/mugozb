const http=require('node:http');
const fs=require('node:fs');
const {performance}=require('node:perf_hooks');
const config=JSON.parse(fs.readFileSync('/private/performance-fixture.json','utf8'));
const concurrency=Number(process.argv[2]||20), count=Number(process.argv[3]||concurrency*3), duration=Number(process.argv[4]||1000);
const agent=new http.Agent({keepAlive:true,maxSockets:concurrency,maxFreeSockets:concurrency});
async function control(path,method='GET'){
 const r=await fetch('http://perf-upstream:8080'+path,{method});if(!r.ok)throw Error('Fixture '+path+' '+r.status);return r.json();
}
function request(cancel=false){return new Promise(resolve=>{
 const started=performance.now();let first=null,body='',timer;
 const data=JSON.stringify({model:'gpt-5.4',stream:true,metadata:{duration_ms:String(duration)},input:'Return PERF_OK'});
 const req=http.request('http://app:8080/v1/responses',{method:'POST',agent,headers:{Authorization:'Bearer '+config.api_key,'Content-Type':'application/json','Content-Length':Buffer.byteLength(data)}},res=>{
  res.on('data',chunk=>{if(first===null)first=performance.now()-started;body+=chunk;});
  res.on('end',()=>{clearTimeout(timer);resolve({status:res.statusCode,ms:performance.now()-started,ttfb:first,complete:body.includes('response.completed')&&body.includes('PERF_OK'),error:res.statusCode!==200?body.slice(0,250):undefined});});
  res.on('error',()=>{});
 });
 req.setTimeout(30000,()=>req.destroy(Error('timeout')));
 req.on('error',e=>{clearTimeout(timer);resolve({status:0,ms:performance.now()-started,complete:false,error:cancel?'cancelled':e.code||e.message});});
 req.end(data);if(cancel)timer=setTimeout(()=>req.destroy(Error('cancelled')),150);
});}
(async()=>{
 await control('/reset','POST');const started=performance.now();let next=0;const rows=[];
 await Promise.all(Array.from({length:concurrency},async()=>{while(next++<count)rows.push(await request(process.argv.includes('--cancel')));}));
 const elapsed=(performance.now()-started)/1000;agent.destroy();
 await new Promise(r=>setTimeout(r,250));const metrics=await control('/metrics');
 const good=rows.filter(r=>r.status===200&&r.complete);const sorted=rows.map(r=>r.ms).sort((a,b)=>a-b), ttfb=rows.map(r=>r.ttfb).filter(v=>v!==null&&v!==undefined).sort((a,b)=>a-b);
 const p=(xs,n)=>xs.length?Math.round(xs[Math.min(xs.length-1,Math.ceil(xs.length*n)-1)]):null;
 const statuses={};for(const r of rows)statuses[r.status]=(statuses[r.status]||0)+1;
 console.log(JSON.stringify({concurrency,count,duration_ms:duration,success:good.length,errors:rows.length-good.length,statuses,elapsed_seconds:+elapsed.toFixed(3),requests_per_second:+(good.length/elapsed).toFixed(2),latency_ms:{p50:p(sorted,.5),p95:p(sorted,.95),p99:p(sorted,.99)},ttfb_ms:{p50:p(ttfb,.5),p95:p(ttfb,.95)},upstream:metrics,error_examples:rows.filter(r=>!r.complete).slice(0,2)}));
})().catch(e=>{console.error(e.message);process.exitCode=1;});
