"""Record the exact integration delta and preserve the pinned original source."""
import difflib,hashlib,json,subprocess,zipfile
from pathlib import Path

ROOT=Path(__file__).resolve().parent
HOST=ROOT/'host'
def git(*args):return subprocess.check_output(['git','-C',str(HOST),*args],stderr=subprocess.DEVNULL)
paths=sorted(set(git('diff','--name-only','HEAD').decode().splitlines()+git('ls-files','--others','--exclude-standard').decode().splitlines()))
records=[];diff=[]
before=ROOT/'evidence'/'source-before'
before.mkdir(parents=True,exist_ok=True)
with zipfile.ZipFile(ROOT/'MODIFIED_FILE.zip','w',zipfile.ZIP_DEFLATED) as archive:
    for name in paths:
        source=HOST/name
        if not source.is_file():raise RuntimeError('unexpected missing source: '+name)
        modified=source.read_bytes()
        try:original=git('show','HEAD:'+name)
        except subprocess.CalledProcessError:original=None
        records.append({'path':name,'original_sha256':hashlib.sha256(original).hexdigest() if original is not None else None,'modified_sha256':hashlib.sha256(modified).hexdigest()})
        if original is not None:
            old=before/name;old.parent.mkdir(parents=True,exist_ok=True);old.write_bytes(original)
        archive.writestr(name,modified)
        oldtext=(original or b'').decode().replace('\r\n','\n')
        newtext=modified.decode().replace('\r\n','\n')
        diff.append('diff --git a/'+name+' b/'+name+'\n')
        if original is None:diff.append('new file mode 100644\n')
        diff.extend(difflib.unified_diff(oldtext.splitlines(True),newtext.splitlines(True),fromfile='a/'+name if original is not None else '/dev/null',tofile='b/'+name))
(ROOT/'DIFF_FILE.diff').write_text(''.join(diff),encoding='utf-8',newline='\n')
(ROOT/'evidence'/'source-hashes.json').write_text(json.dumps({'base_commit':git('rev-parse','HEAD').decode().strip(),'files':records},indent=2)+'\n')
print('SOURCE_RECORDED files='+str(len(records))+' modified_archive_sha256='+hashlib.sha256((ROOT/'MODIFIED_FILE.zip').read_bytes()).hexdigest())
