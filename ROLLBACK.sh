#!/usr/bin/env sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
target=${1:-"$script_dir/setup-lan-gpt.ps1"}
original=${2:-"$script_dir/.rollback/setup-lan-gpt.before-client-auto.ps1"}

if [ ! -f "$original" ]; then
  printf '%s\n' "ROLLBACK ERROR: original file not found: $original" >&2
  exit 2
fi

cp -- "$original" "$target"
hash_line=$(sha256sum -- "$target")
hash=${hash_line%% *}
hash=${hash#\\}
printf '%s\n' 'ROLLBACK PASS'
printf '%s\n' "target=$target"
printf '%s\n' "sha256=$hash"
