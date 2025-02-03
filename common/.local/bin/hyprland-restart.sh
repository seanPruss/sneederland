#!/usr/bin/env bash

if pgrep waybar; then
	killall waybar
	hyprctl dispatch exec waybar
else
	hyprctl dispatch exec waybar
fi

if pgrep dunst; then
	killall dunst
	hyprctl dispatch exec dunst
else
	hyprctl dispatch exec dunst
fi

if pgrep hyprpaper; then
	killall hyprpaper
	hyprctl dispatch exec hyprpaper
else
	hyprctl dispatch exec hyprpaper
fi

pgrep pypr && pypr reload
