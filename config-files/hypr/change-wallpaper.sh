#!/bin/bash

update-wallpaper() {
	WALLPAPER="$(fd -a . ~/.config/hypr/wallpapers | shuf -n 1)"
	cp -f $WALLPAPER ~/.cache/current_wallpaper
	swww img --transition-type any "$WALLPAPER"
}

if [[ $1 == "start" ]]; then
	while true; do
		update-wallpaper
		sleep 900
	done
elif [[ $1 == "update-wallpaper" ]]; then
	update-wallpaper
fi
