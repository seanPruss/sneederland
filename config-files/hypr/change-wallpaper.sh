#!/bin/bash

update-wallpaper() {
	WALLPAPER="$(fd -a . ~/.config/hypr/wallpapers | shuf -n 1)"
	cp -f $WALLPAPER ~/.cache/current_wallpaper
	swww img --transition-type any "$WALLPAPER"
}

if [[ -z $1 ]]; then
	while true; do
		update-wallpaper
		sleep 900
	done
else
	update-wallpaper
fi
