#!/bin/bash
set -euo pipefail

# Config repair is idempotent and never recreates users or tokens.
python3 /scripts/hass_fixture.py /config
marker=/config/.hommie-e2e-initialized
if [ ! -f "$marker" ]; then
    if [ -f /config/.storage/auth ]; then
        # Adopt existing persistent config; readiness verifies its credentials.
        touch "$marker"
    else
        private_result=/config/.hommie-e2e-bootstrap.json
        python3 /scripts/hass-init.py -c /config -u "${USERNAME:-admin}" -p "${PASSWORD:-yourpassword}" > "$private_result"
        python3 - "$private_result" <<'PY'
import json, os, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
path = '/hass_init_conf/.env'
with open(path + '.tmp', 'w') as f:
    f.write('HASS_TOKEN=' + data['access_token'] + '\n')
    f.write('HASS_USERNAME=' + data['username'] + '\n')
    f.write('HASS_PASSWORD=' + data['password'] + '\n')
os.chmod(path + '.tmp', 0o600)
os.replace(path + '.tmp', path)
PY
        rm -f "$private_result"
        touch "$marker"
    fi
fi
exec python3 -m homeassistant --config /config
