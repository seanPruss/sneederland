#!/usr/bin/env bash

killall dunst
dunst &

pgrep hyprpaper || hyprpaper &

pypr wall next

killall waybar
waybar &
