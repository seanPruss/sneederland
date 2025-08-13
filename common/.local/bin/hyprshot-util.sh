#!/usr/bin/env bash

MODE=$(echo -e "output\nwindow\nregion" | rofi -dmenu -i) || exit
SAVE=$(echo -e "Save\nDon't save" | rofi -dmenu -i) || exit

[[ $SAVE = "Don't save" ]] && CLIP="--clipboard-only"

hyprshot -m "$MODE" "$CLIP" -t 1000
