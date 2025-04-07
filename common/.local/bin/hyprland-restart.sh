#!/usr/bin/env bash

killall waybar
waybar &

killall dunst
dunst &

pgrep hyprpaper || hyprpaper &

pypr wall next
