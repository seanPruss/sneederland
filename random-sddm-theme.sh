#!/usr/bin/env bash

# Directory containing themes
THEME_DIR="/usr/share/sddm/themes"

# Get a random theme
RANDOM_THEME=$(ls "$THEME_DIR" | shuf -n 1)

# Update SDDM configuration
CONFIG_FILE="/etc/sddm.conf.d/10-theme.conf"

# Write the random theme to the config
echo "[Theme]" >"$CONFIG_FILE"
echo "Current=$RANDOM_THEME" >>"$CONFIG_FILE"
