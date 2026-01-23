#!/usr/bin/env bash

OPTION=$(echo -e "screenshot\nscreenshotScreen\nscreenshotWindow" | tofi)

[[ -n $OPTION ]] || exit
dms ipc call niri "$OPTION"
sleep 7
wl-paste | satty --filename -
