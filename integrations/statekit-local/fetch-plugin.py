"""Fetch the pinned publisher package and verify its exact release hash."""
import hashlib,urllib.request
from pathlib import Path

root=Path(__file__).resolve().parent
expected='e09ac56a13af19f819d3107047f05766401287de853971d406940b68edc6cb5b'
target=root/'statekit.s2plugin'
if not target.exists():
    url='https://github.com/wangyunjeff/sub2api-state-kit/releases/download/v0.3.4/sub2api-state-kit_plugin_v0.3.4.s2plugin'
    with urllib.request.urlopen(url,timeout=90) as response:data=response.read(32*1024*1024)
    assert hashlib.sha256(data).hexdigest()==expected,'release hash mismatch'
    target.write_bytes(data)
assert hashlib.sha256(target.read_bytes()).hexdigest()==expected,'existing package differs from pinned release'
print('PLUGIN_PACKAGE_VERIFIED '+expected)
