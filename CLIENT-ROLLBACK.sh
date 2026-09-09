#!/usr/bin/env sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
target=${1:-"$script_dir/setup-gpt-client.cmd"}
original=${2:-"$script_dir/.rollback/setup-gpt-client.before-no-proxy.cmd"}

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
