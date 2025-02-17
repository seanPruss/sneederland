#!/usr/bin/env bash

WALLPAPER="$(fd . ~/Pictures/wallpapers -tf --follow | shuf -n 1)"
cp -f "$WALLPAPER" ~/.cache/current_wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
