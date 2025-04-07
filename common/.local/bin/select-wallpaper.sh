#!/usr/bin/env bash

cd ~/Pictures/wallpapers || exit
WALLPAPER="$(fd . -tf --follow | tofi --config="$HOME"/.config/tofi/wallpaper-selector-config --fuzzy-match=true)"
if [ -n "$WALLPAPER" ]; then
	WALLPAPER=$HOME/Pictures/wallpapers/$WALLPAPER
	cp -f "$WALLPAPER" ~/.cache/current_wallpaper
	hyprctl hyprpaper reload ,"$WALLPAPER"
fi
