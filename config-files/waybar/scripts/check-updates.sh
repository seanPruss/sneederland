#!/bin/bash

which yay &>/dev/null || exit 1

UPDATE_COUNT=$(yay -Qu | wc -l)

[[ $UPDATE_COUNT -gt 0 ]] && notify-send " $UPDATE_COUNT updates available"
echo "$UPDATE_COUNT"
