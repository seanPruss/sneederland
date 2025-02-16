#!/usr/bin/env bash

WALLPAPER="$(fd . ~/Pictures/wallpapers -tf --follow | tofi --config=$HOME/.config/tofi/wallpaper-selector-config --fuzzy-match=true)"

$HOME/.local/bin/change-wallpaper.sh "$WALLPAPER"
