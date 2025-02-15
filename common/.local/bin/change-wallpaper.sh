#!/usr/bin/env bash

cp -f "$1" ~/.cache/current_wallpaper
hyprctl hyprpaper reload ,"$1"
