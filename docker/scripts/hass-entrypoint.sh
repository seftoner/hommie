#!/bin/bash
set -e

INIT_FLAG="/hass_init_conf/.initialized"
ENV_FILE="/hass_init_conf/.env"

# Make scripts executable
chmod +x /scripts/hass-init.py

# Run initialization
if [ ! -f "$INIT_FLAG" ]; then
    echo "[$(date)] Running first-time initialization..."
    
    if ! python3 /scripts/hass-init.py -c /config -u "${USERNAME:-}" -p "${PASSWORD:-}" | tee "$INIT_FLAG"; then
        echo "[$(date)] Initialization failed!"
        rm -f "$INIT_FLAG"
        exit 1
    fi

    echo "[$(date)] Initialization completed successfully"
    TOKEN=$(jq -r '.access_token' "$INIT_FLAG")
    

    cat > "$ENV_FILE" <<EOF
HASS_SERVER=http://localhost:8123
HASS_TOKEN=$TOKEN
EOF

fi

# Start Home Assistant
exec python3 -m homeassistant --config /config
