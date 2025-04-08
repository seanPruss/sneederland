#!/usr/bin/env bash

if [ -n "$1" ]; then
	cp -f "$1" ~/.cache/current_wallpaper
	hyprctl hyprpaper reload ,"$1"
fi
