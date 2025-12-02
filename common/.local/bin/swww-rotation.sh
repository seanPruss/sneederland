#!/usr/bin/env bash

while true; do
	WALLPAPER=$(fd . ~/Pictures/wallpapers | shuf -n 1)
	swww img "$WALLPAPER"
	cp -f "$WALLPAPER" ~/.cache/current_wallpaper
	sleep 600
done
