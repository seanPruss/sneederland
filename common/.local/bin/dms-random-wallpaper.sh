#!/usr/bin/env bash

dms ipc call wallpaper set "$(fd -tl . ~/Pictures/wallpapers | shuf -n 1)"
dms ipc theme toggle
dms ipc theme toggle
dms ipc theme dark
