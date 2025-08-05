#!/usr/bin/env bash

MODE=$(echo -e "output\nwindow\nregion" | rofi -dmenu -i)
SAVE=$(echo -e "Save\nDon't save" | rofi -dmenu -i)

[[ $SAVE = "Don't save" ]] && CLIP="--clipboard-only"

hyprshot -m "$MODE" "$CLIP" -t 1000
