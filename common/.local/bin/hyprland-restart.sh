#!/usr/bin/env bash

pgrep waybar && killall waybar
pgrep waybar || hyprctl dispatch exec waybar

pgrep dunst && killall dunst
pgrep dunst || hyprctl dispatch exec dunst

pgrep hyprpaper && killall hyprpaper
pgrep hyprpaper || hyprctl dispatch exec hyprpaper

pgrep pypr && pypr reload
