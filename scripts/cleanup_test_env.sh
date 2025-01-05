#!/bin/bash
set -e

# Navigate to project root
cd "$(dirname "$0")/.."

# Remove .patrol.env
rm -f .patrol.env

# Navigate to docker directory
cd docker

# Stop containers
docker compose down

# Clean up initialization files
rm -f hass_init_conf/.initialized
rm -f hass_init_conf/.env

echo "Test environment cleanup complete!"
