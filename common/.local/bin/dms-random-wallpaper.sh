#!/usr/bin/env bash

dms ipc call wallpaper set $(fd . ~/Pictures/wallpapers | shuf -n 1)
