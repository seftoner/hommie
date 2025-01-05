#!/bin/bash
set -e

# Navigate to docker directory
cd "$(dirname "$0")/../docker"

echo "Initialize Home Assistant"

# Start docker compose
docker compose up -d

# Wait for initialization and env file (max 30 seconds)
for i in {1..30}; do
    if [ -f "hass_init_conf/.initialized" ] && [ -f "hass_init_conf/.env" ]; then
        # Verify env file has content
        if [ -s "hass_init_conf/.env" ]; then
            break
        fi
    fi
    echo "Waiting for Home Assistant initialization... ($i/30)"
    sleep 1
done

# Check both files exist and have content
if [ ! -f "hass_init_conf/.initialized" ] || [ ! -f "hass_init_conf/.env" ]; then
    echo "Error: Home Assistant initialization files missing"
    exit 1
fi

if [ ! -s "hass_init_conf/.env" ]; then
    echo "Error: .env file is empty"
    exit 1
fi

# Extract token with portable command
HASS_TOKEN=$(grep 'HASS_TOKEN=' hass_init_conf/.env | sed 's/HASS_TOKEN=//')

if [ -z "$HASS_TOKEN" ]; then
    echo "Error: Failed to extract HASS_TOKEN from .env file"
    echo "Content of .env file:"
    cat hass_init_conf/.env
    exit 1
fi

# Create patrol env file with verification
echo "HASS_TOKEN=$HASS_TOKEN" > "../.patrol.env"

# Verify patrol env file was created correctly
if ! grep -q "HASS_TOKEN=$HASS_TOKEN" "../.patrol.env"; then
    echo "Error: Failed to write token to .patrol.env"
    exit 1
fi

echo "Test environment setup complete!"
