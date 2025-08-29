#!/usr/bin/env bash

MODE=$(echo -e "output\nwindow\nregion" | rofi -dmenu -i) || exit

hyprshot -m "$MODE" --raw -t 1000 | swappy -f -
