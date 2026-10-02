#!/bin/sh
set -eu
e2e_script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
# Normal cleanup stops services and preserves fixture data and credentials.
exec "$e2e_script_dir/e2e.sh" backend stop "$@"
