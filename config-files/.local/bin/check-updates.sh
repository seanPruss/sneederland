#!/usr/bin/env bash

which yay &>/dev/null || exit 1
which checkupdates &>/dev/null || exit 1

while ! ping -c 1 archlinux.org &>/dev/null; do
	true
done

NOTIFICATION_SENT=/tmp/update_notif
OFFICIAL_UPDATES=$(checkupdates | wc -l)
AUR_UPDATES=$(yay -Qua | wc -l)
UPDATE_COUNT=$((OFFICIAL_UPDATES + AUR_UPDATES))

URGENCY="low"
[[ $UPDATE_COUNT -gt 50 ]] && URGENCY="critical"

[[ $UPDATE_COUNT -eq 0 ]] && [[ -e $NOTIFICATION_SENT ]] && rm $NOTIFICATION_SENT

[[ $UPDATE_COUNT -gt 1 ]] && PLURAL="s"

[[ $UPDATE_COUNT -gt 0 ]] && [[ ! -e $NOTIFICATION_SENT ]] && notify-send "$UPDATE_COUNT update$PLURAL available" "$OFFICIAL_UPDATES from pacman $AUR_UPDATES from AUR" -u $URGENCY -i edit-download && touch $NOTIFICATION_SENT
echo "$UPDATE_COUNT"
