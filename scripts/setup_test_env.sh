#!/bin/sh
# Provision the persistent test fixture; Patrol owns test execution.
set -eu
umask 077
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(dirname "$script_dir")
for tool in docker curl jq patrol; do
    command -v "$tool" >/dev/null || { echo "Required local tool missing: $tool" >&2; exit 1; }
done
ha_port=${E2E_HA_PORT:-8123}
bridge_port=${E2E_BRIDGE_PORT:-3000}
proxy_port=${E2E_PROXY_PORT:-18124}
control_port=${E2E_CONTROL_PORT:-18474}
for port in "$ha_port" "$bridge_port" "$proxy_port" "$control_port"; do
    case "$port" in ''|*[!0-9]*) echo 'Invalid fixture port' >&2; exit 1;; esac
    [ "$port" -gt 0 ] && [ "$port" -le 65535 ] || exit 1
done
[ "$(printf '%s\n' "$ha_port" "$bridge_port" "$proxy_port" "$control_port" | sort -u | wc -l | tr -d ' ')" = 4 ] || {
    echo 'Fixture ports must be distinct' >&2; exit 1;
}
export E2E_HA_PORT="$ha_port" E2E_BRIDGE_PORT="$bridge_port" E2E_PROXY_PORT="$proxy_port" E2E_CONTROL_PORT="$control_port"
compose() { docker compose -f "$repo_root/docker/docker-compose.yml" -p homeassistant-test "$@"; }
# Never recreate an old container whose /config has not been preserved.
if docker inspect homeassistant-test >/dev/null 2>&1; then
    mount=$(docker inspect --format '{{json .Mounts}}' homeassistant-test)
    printf '%s' "$mount" | jq -e 'any(.[]; .Destination == "/config" and .Name == "homeassistant-test_ha_config")' >/dev/null || {
        echo 'Existing HA configuration needs explicit volume migration; nothing was reset' >&2; exit 1;
    }
fi
running=$(compose ps --status running --format '{{.Service}}')
for service in homeassistant hass-cli-web toxiproxy; do
    if ! printf '%s\n' "$running" | grep -qx "$service"; then
        compose up -d --no-deps "$service"
    fi
done
credential_file="$repo_root/docker/hass_init_conf/.env"
# Poll only reads. A timed-out mutation is never blindly retried.
ready=0
attempt=0
while [ "$attempt" -lt 60 ]; do
    attempt=$((attempt + 1))
    if [ -f "$credential_file" ]; then
        token=$(sed -n 's/^HASS_TOKEN=//p' "$credential_file")
        if [ -n "$token" ] &&
            printf 'Authorization: Bearer %s\n' "$token" | curl -fsS --max-time 5 -H @- -o /dev/null "http://127.0.0.1:$ha_port/api/" 2>/dev/null &&
            curl -fsS --max-time 5 -o /dev/null "http://127.0.0.1:$bridge_port/health" 2>/dev/null; then
            ready=1; break
        fi
    fi
    sleep 2
done
[ "$ready" = 1 ] || { echo 'Fixture readiness failed; existing data and credentials retained' >&2; exit 1; }
cli_ws() {
    printf '%s' "$token" | jq -Rs --arg type "$1" --argjson payload "${2:-null}" \
        '{token: ., args: (["raw", "ws", $type] + (if $payload == null then [] else ["--json=" + ($payload | tojson)] end))}' |
        curl -fsS --max-time 25 -H 'Content-Type: application/json' --data-binary @- "http://127.0.0.1:$bridge_port/cli" |
        jq -e 'if .exit_code == 0 then (.stdout | fromjson | if .success then .result else error("HA rejected fixture operation") end) else error("Fixture CLI failed") end'
}
areas=$(cli_ws config/area_registry/list)
for area in Kitchen 'Living Room' Bedroom; do
    if ! printf '%s' "$areas" | jq -e --arg name "$area" 'any(.[]; .name == $name)' >/dev/null; then
        payload=$(jq -nc --arg name "$area" '{name: $name}')
        cli_ws config/area_registry/create "$payload" >/dev/null
    fi
done
printf 'Authorization: Bearer %s\n' "$token" | curl -fsS --max-time 5 -H @- -o /dev/null "http://127.0.0.1:$ha_port/api/states/light.kitchen_light"
routes=$(curl -fsS --max-time 5 "http://127.0.0.1:$control_port/proxies")
route_path=/proxies
if printf '%s' "$routes" | jq -e 'has("hommie_ha")' >/dev/null; then route_path=/proxies/hommie_ha; fi
curl -fsS --max-time 5 -H 'Content-Type: application/json' --data-binary \
    '{"name":"hommie_ha","listen":"0.0.0.0:18124","upstream":"homeassistant:8123","enabled":true}' \
    -o /dev/null "http://127.0.0.1:$control_port$route_path"
# Patrol reads this file automatically. Do not source dotenv as shell code.
{
    cat "$credential_file"
    printf '\nE2E_APP_SERVER_URL=http://127.0.0.1:%s\n' "$proxy_port"
    printf 'E2E_FIXTURE_CONTROL_URL=http://127.0.0.1:%s\n' "$bridge_port"
    printf 'E2E_FAULT_CONTROL_URL=http://127.0.0.1:%s\n' "$control_port"
    printf 'E2E_RUN_ID=local_%s_%s\n' "$(date +%s)" "$$"
    printf 'E2E_COLD_PHASE=none\n'
} > "$repo_root/app/.patrol.env.tmp"
mv "$repo_root/app/.patrol.env.tmp" "$repo_root/app/.patrol.env"
echo 'Fixture ready. Run the installed Patrol CLI from app/.'
