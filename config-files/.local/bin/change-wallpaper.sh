#!/usr/bin/env bash

cp -f $1 ~/.cache/current_wallpaper
swww img --transition-type any "$1"
