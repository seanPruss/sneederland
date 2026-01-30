#!/usr/bin/env bash

dms ipc call wallpaper set "$(fd -tf . ~/Pictures/wallpapers | shuf -n 1)"
