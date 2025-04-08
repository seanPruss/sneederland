#!/usr/bin/env bash

cd ~/Pictures/wallpapers || exit
WALLPAPER="$(fd . -tf --follow | rofi -dmenu)"
if [ -n "$WALLPAPER" ]; then
	WALLPAPER=$HOME/Pictures/wallpapers/$WALLPAPER
	cp -f "$WALLPAPER" ~/.cache/current_wallpaper
	hyprctl hyprpaper reload ,"$WALLPAPER"
fi
