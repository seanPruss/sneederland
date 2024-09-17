#!/bin/bash
while true; do
	WALLPAPER="$(fd -a . $HOME/.config/hypr/wallpapers | sort -R | head -1)"
	cp -f $WALLPAPER ~/.cache/current_wallpaper
	swww img --transition-type any "$WALLPAPER"
	sleep 600
done
