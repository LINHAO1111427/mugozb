"""Reconstruct the pinned, adapted host in a new local directory."""
import argparse,subprocess
from pathlib import Path

ROOT=Path(__file__).resolve().parent
BASE='aea725f2ea644d5592d0bbb1d63b607efa7e200a'
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--output',type=Path,default=ROOT/'host')
args=p.parse_args()
target=args.output.resolve()
if target.exists():p.error('output must be a new directory; existing source is preserved')
subprocess.run(['git','clone','--no-checkout','--depth','1','--branch','v0.2.7','https://github.com/Wei-Shaw/sub2api.git',str(target)],check=True)
subprocess.run(['git','-C',str(target),'config','core.autocrlf','false'],check=True)
head=subprocess.check_output(['git','-C',str(target),'rev-parse','HEAD'],text=True).strip()
assert head==BASE,'upstream version changed'
subprocess.run(['git','-C',str(target),'checkout','-b','local/statekit-controls',BASE],check=True)
subprocess.run(['git','-C',str(target),'apply','--check',str(ROOT/'DIFF_FILE.diff')],check=True)
subprocess.run(['git','-C',str(target),'apply',str(ROOT/'DIFF_FILE.diff')],check=True)
print('HOST_PREPARED',target)
