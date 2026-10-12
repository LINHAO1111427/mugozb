#!/usr/bin/env bash
set -euo pipefail

TARGET=${1:?usage: ROLLBACK.sh <artifact-directory> [integration-json]}
CONFIG=${2:-"$TARGET/integration.json"}
BASELINE="$TARGET/BASELINE_FILE.json"
MODIFIED="$TARGET/MODIFIED_FILE.json"

[ -f "$BASELINE" ] && [ -f "$MODIFIED" ] && [ -f "$CONFIG" ]
expected=$(sha256sum "$MODIFIED" | awk '{print $1}' | sed 's/^\\//')
current=$(sha256sum "$CONFIG" | awk '{print $1}' | sed 's/^\\//')
[ "$current" = "$expected" ] || { echo "ROLLBACK_REFUSED hash_mismatch"; exit 2; }
cp "$BASELINE" "$CONFIG"
restored=$(sha256sum "$CONFIG" | awk '{print $1}' | sed 's/^\\//')
expected_restored=$(sha256sum "$BASELINE" | awk '{print $1}' | sed 's/^\\//')
[ "$restored" = "$expected_restored" ]
printf 'ROLLBACK_OK restored=%s modified_artifact=%s\n' "$restored" "$MODIFIED"
