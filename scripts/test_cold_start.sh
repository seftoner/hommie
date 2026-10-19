#!/bin/sh
# Only the real two-process cold-start boundary needs host coordination.
# Test execution and device selection remain Patrol's responsibility.
set -eu
umask 077
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(dirname "$script_dir")
device=${1:?Pass an already booted iPhone Simulator UDID}
[ "$#" -eq 1 ] || { echo 'Expected one simulator UDID' >&2; exit 1; }
for tool in patrol xcrun jq curl; do command -v "$tool" >/dev/null || exit 1; done
xcrun simctl list devices booted -j | jq -e --arg id "$device" \
    'any(.devices[][]; .udid == $id and .isAvailable and (.name | startswith("iPhone")))' >/dev/null
[ -f "$repo_root/app/.patrol.env" ] || { echo 'Run setup_test_env.sh first' >&2; exit 1; }
control_url=$(sed -n 's/^E2E_FAULT_CONTROL_URL=//p' "$repo_root/app/.patrol.env")
run_id=$(sed -n 's/^E2E_RUN_ID=//p' "$repo_root/app/.patrol.env")
case "$run_id" in ''|*[!a-zA-Z0-9_-]*) echo 'Invalid fixture run ID' >&2; exit 1;; esac
state_dir="$repo_root/.dart_tool/cold-start"
mkdir -p "$state_dir"
lock_dir="$state_dir/lock"
mkdir "$lock_dir" 2>/dev/null || { echo 'A cold-start flow already owns the fixture; inspect the existing lock before retrying' >&2; exit 1; }
restore() {
    curl -fsS --max-time 10 -H 'Content-Type: application/json' --data-binary '{"enabled":true}' \
        -o /dev/null "$control_url/proxies/hommie_ha"
}
cleanup() {
    result=$?
    trap - EXIT INT TERM
    if ! restore; then [ "$result" -ne 0 ] || result=1; fi
    rm -rf "$lock_dir"
    exit "$result"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
cd "$repo_root/app"
restore
patrol test --device "$device" --target integration_test/cold_start_seed_test.dart \
    --dart-define E2E_COLD_PHASE=seed --no-uninstall
container=$(xcrun simctl get_app_container "$device" com.seftoner.hommie data)
checkpoint=$(find "$container/Library" -name hommie_e2e_checkpoint.json -type f -print)
[ -f "$checkpoint" ] || { echo 'Cold seed checkpoint missing' >&2; exit 1; }
jq -e --arg run "$run_id" '.runId == $run and (.pid | type == "number")' "$checkpoint" >/dev/null
cp "$checkpoint" "$state_dir/seed.json"
xcrun simctl terminate "$device" com.seftoner.hommie || true
if xcrun simctl spawn "$device" launchctl list | awk '/UIKitApplication:com.seftoner.hommie\[/ && $1 ~ /^[0-9]+$/ { found=1 } END {exit !found}'; then
    echo 'Seed process is still running' >&2; exit 1
fi
curl -fsS --max-time 10 -H 'Content-Type: application/json' --data-binary '{"enabled":false}' \
    -o /dev/null "$control_url/proxies/hommie_ha"
patrol test --device "$device" --target integration_test/cold_start_verify_test.dart \
    --dart-define E2E_COLD_PHASE=verify --no-uninstall
container=$(xcrun simctl get_app_container "$device" com.seftoner.hommie data)
checkpoint=$(find "$container/Library" -name hommie_e2e_checkpoint.json -type f -print)
[ -f "$checkpoint" ] || exit 1
jq -e --arg run "$run_id" '.runId == $run and (.verifyPid | type == "number") and .pid != .verifyPid' "$checkpoint" >/dev/null
cp "$checkpoint" "$state_dir/verified.json"
echo 'Cold launch passed with different seed and verify processes.'
