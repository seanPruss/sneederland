#!/usr/bin/env bash

pgrep waybar && killall waybar
hyprctl dispatch exec waybar

pgrep dunst && killall dunst
hyprctl dispatch exec dunst

pgrep hyprpaper && killall hyprpaper
hyprctl dispatch exec hyprpaper

pgrep pypr && pypr reload
