#!/bin/bash
while true; do
	WALLPAPER="$(fd -a . ~/.config/hypr/wallpapers | sort -R | head -1)"
	cp -f $WALLPAPER ~/.cache/current_wallpaper
	swww img --transition-type any "$WALLPAPER"
	sleep 900
done
