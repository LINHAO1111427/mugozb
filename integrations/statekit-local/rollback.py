"""Conditionally restore only this integration's source delta in a local tree."""
import argparse,hashlib,json
from pathlib import Path

ROOT=Path(__file__).resolve().parent
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('target',type=Path)
target=p.parse_args().target.resolve()
if not target.is_dir():p.error('target directory does not exist')
records=json.loads((ROOT/'evidence/source-hashes.json').read_text())['files']
def digest(path):return hashlib.sha256(path.read_bytes()).hexdigest()
for record in records:
    path=target/record['path']
    if path.is_symlink() or not path.resolve().is_relative_to(target):p.error('unexpected source path')
    if not path.is_file() or digest(path)!=record['modified_sha256']:p.error('source changed: '+record['path'])
    if record['original_sha256']:
        original=ROOT/'evidence/source-before'/record['path']
        if digest(original)!=record['original_sha256']:p.error('original backup mismatch')
for record in records:
    path=target/record['path']
    if record['original_sha256']:
        path.write_bytes((ROOT/'evidence/source-before'/record['path']).read_bytes())
        assert digest(path)==record['original_sha256']
    else:path.unlink()
print('ROLLBACK_OK restored_original_hashes='+str(len(records)))
