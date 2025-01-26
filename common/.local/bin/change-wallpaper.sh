#!/usr/bin/env bash

cp -f "$1" ~/.cache/current_wallpaper
hyprctl hyprpaper preload "$1"
hyprctl hyprpaper wallpaper ", $1"
