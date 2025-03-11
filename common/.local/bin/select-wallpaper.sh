#!/usr/bin/env bash

WALLPAPER="$(fd . ~/Pictures/wallpapers -tf --follow | sed 's/\/home\/seanp\/Pictures\/wallpapers\///g' | tofi --config="$HOME"/.config/tofi/wallpaper-selector-config --fuzzy-match=true)"

WALLPAPER=$HOME/Pictures/wallpapers/$WALLPAPER
cp -f "$WALLPAPER" ~/.cache/current_wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
