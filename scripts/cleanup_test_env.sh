#!/bin/sh
# Stop services without deleting the persistent fixture or credentials.
set -eu
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
exec docker compose -f "$script_dir/../docker/docker-compose.yml" -p homeassistant-test stop
