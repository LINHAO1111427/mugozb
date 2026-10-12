#!/usr/bin/env sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "$script_dir/LOCAL-SWITCH-ROLLBACK.ps1"
