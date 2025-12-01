#!/bin/bash
set -e

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "🚫 Error: Docker daemon is not running"
    echo "Please start Docker and try again"
    exit 1
fi

# Function to display animated loading text
display_loading() {
    local elapsed=$1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    printf "\r${spinstr:$(( (elapsed/1) % 10 )):1} Waiting for Home Assistant initialization..."
}

# Navigate to docker directory
cd "$(dirname "$0")/../docker"

echo "🏠 Initialize Home Assistant"

# Start docker compose with error handling
if ! docker compose up -d; then
    echo "🚫 Error: Failed to start Docker containers"
    echo "Please check Docker logs for more details:"
    echo "docker compose logs"
    exit 1
fi

# Wait for initialization and env file (max 180 seconds)
elapsed=0
while [ $elapsed -lt 30 ]; do
    if [ -f "hass_init_conf/.initialized" ] && [ -f "hass_init_conf/.env" ]; then
        if [ -s "hass_init_conf/.env" ]; then
            printf "\rHome Assistant initialized successfully!           \n"
            break
        fi
    fi
    display_loading $elapsed
    sleep 1
    ((elapsed++))
done

if [ $elapsed -eq 180 ]; then
    printf "\rTimeout: Home Assistant initialization took too long    \n"
    exit 1
fi

# Check both files exist and have content
if [ ! -f "hass_init_conf/.initialized" ] || [ ! -f "hass_init_conf/.env" ]; then
    echo "Error: Home Assistant initialization files missing"
    exit 1
fi

if [ ! -s "hass_init_conf/.env" ]; then
    echo "🚫 Error: .env file is empty"
    exit 1
fi

# Extract token with portable command
HASS_TOKEN=$(grep 'HASS_TOKEN=' hass_init_conf/.env | sed 's/HASS_TOKEN=//')

if [ -z "$HASS_TOKEN" ]; then
    echo "🚫 Error: Failed to extract HASS_TOKEN from .env file"
    echo "Content of .env file:"
    cat hass_init_conf/.env
    exit 1
fi

# Create patrol env file in app folder with verification
echo "HASS_TOKEN=$HASS_TOKEN" > "../app/.patrol.env"

# Verify patrol env file was created correctly
if ! grep -q "HASS_TOKEN=$HASS_TOKEN" "../app/.patrol.env"; then
    echo "Error: Failed to write token to .patrol.env"
    exit 1
fi

echo "✅ Test environment setup complete!"
