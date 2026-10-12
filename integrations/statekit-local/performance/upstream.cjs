const http = require('node:http');
let active=0, peak=0, completed=0, cancelled=0, connections=0;
const server=http.createServer(async (req,res)=>{
  if(req.url==='/metrics') { res.setHeader('Content-Type','application/json'); return res.end(JSON.stringify({active,peak,completed,cancelled,connections})); }
  if(req.url==='/reset' && req.method==='POST') { if(active){res.statusCode=409;return res.end('active');} peak=completed=cancelled=connections=0;return res.end('{}'); }
  if(req.method!=='POST' || !req.url.endsWith('/responses')) {res.statusCode=404;return res.end();}
  let body='';for await(const chunk of req){body+=chunk;if(body.length>65536){res.statusCode=413;return res.end();}}
  let payload;try{payload=JSON.parse(body);}catch{res.statusCode=400;return res.end();}
  if(req.headers.authorization!=='Bearer local-performance-fixture') {res.statusCode=401;return res.end();}
  const duration=Math.min(5000,Math.max(50,Number(payload.metadata?.duration_ms)||1000));
  const id='resp_'+Math.random().toString(36).slice(2), model=payload.model;
  active++;peak=Math.max(peak,active);let finished=false;
  const timers=[];res.on('close',()=>{active--;if(!finished)cancelled++;timers.forEach(clearTimeout);});
  res.writeHead(200,{'Content-Type':'text/event-stream','Cache-Control':'no-cache','X-Request-Id':id});res.flushHeaders();
  const send=(type,data)=>res.write('event: '+type+'\ndata: '+JSON.stringify({type,...data})+'\n\n');
  send('response.created',{response:{id,object:'response',model,status:'in_progress',output:[]}});
  timers.push(setTimeout(()=>send('response.output_text.delta',{delta:'PERF_OK'}),duration/2));
  timers.push(setTimeout(()=>{
    send('response.completed',{response:{id,object:'response',model,status:'completed',output:[{id:'msg_'+id,type:'message',role:'assistant',status:'completed',content:[{type:'output_text',text:'PERF_OK',annotations:[]}]}],usage:{input_tokens:10,output_tokens:2,total_tokens:12}}});
    finished=true;completed++;res.end();
  },duration));
});
server.on('connection',()=>connections++);
server.keepAliveTimeout=65000;
server.listen(8080,'0.0.0.0',()=>console.log('FIXTURE_UPSTREAM_READY'));
