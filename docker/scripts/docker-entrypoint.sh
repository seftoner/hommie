#!/bin/bash

# Make scripts executable
chmod +x /scripts/init.sh
chmod +x /scripts/setup_ha.py

# Run initialization script
/scripts/init.sh

# Start Home Assistant
python3 -m homeassistant --config /config
