#!/bin/sh
set -eu
e2e_script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
exec "$e2e_script_dir/e2e.sh" backend start "$@"
