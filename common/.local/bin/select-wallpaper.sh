#!/usr/bin/env bash

WALLPAPER="$(fd . ~/Pictures/wallpapers -tf --follow | tofi --config=$HOME/.config/tofi/wallpaper-selector-config --fuzzy-match=true)"

cp -f "$WALLPAPER" ~/.cache/current_wallpaper
hyprctl hyprpaper reload ,"$1"
