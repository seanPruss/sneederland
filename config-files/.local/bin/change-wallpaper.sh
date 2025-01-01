#!/usr/bin/env bash

update-wallpaper() {
	cp -f $1 ~/.cache/current_wallpaper
	hyprctl hyprpaper preload "$1"
	hyprctl hyprpaper wallpaper ", $1"
}
WALLPAPER_COUNT=$(hyprctl hyprpaper listloaded | wc -l)

if ((WALLPAPER_COUNT <= 20)); then
	update-wallpaper "$@"
else
	rand=$($RANDOM % 4)
	if ((rand == 0)); then
		update-wallpaper "$@"
	else
		NEW_WALLPAPER=$(hyprctl hyprpaper listloaded | shuf -n 1)
		update-wallpaper "$NEW_WALLPAPER"
	fi
fi
