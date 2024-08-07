#!/bin/bash

which yay &>/dev/null || exit 1
which checkupdates &>/dev/null || exit 1

OFFICIAL_UPDATES=$(checkupdates | wc -l)
AUR_UPDATES=$(yay -Qua | wc -l)
UPDATE_COUNT=$((OFFICIAL_UPDATES + AUR_UPDATES))

URGENCY="low"
[[ $UPDATE_COUNT -gt 100 ]] && URGENCY="critical"

[[ $UPDATE_COUNT -gt 0 ]] && notify-send " $UPDATE_COUNT updates available" "$OFFICIAL_UPDATES from pacman $AUR_UPDATES from AUR" -u $URGENCY
echo "$UPDATE_COUNT"
