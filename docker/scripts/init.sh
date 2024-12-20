#!/bin/bash
INIT_FLAG="/data/.initialized"

if [ ! -f "$INIT_FLAG" ]; then
    echo "Running first-time initialization..."
    python3 /scripts/setup_ha.py
    touch "$INIT_FLAG"
else
    echo "Already initialized, skipping..."
fi