#!/usr/bin/env bash

dms ipc call wallpaper set "$(fd -tl . ~/Pictures/wallpapers | shuf -n 1)"
