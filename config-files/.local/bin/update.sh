#!/usr/bin/env bash

show-updating() {
	local VALUE=0
	while ps | grep $1 &>/dev/null; do
		((VALUE >= 100)) && ((VALUE = 0))
		dunstify -u low -r 9995 -h int:value:"$VALUE" -i "edit-download" "Updating" "$2 packages updating" -t 500
		((VALUE++))
	done
	sleep 1
}

update() {
	sudo touch /tmp/update
	yay -Syyu --noconfirm &
	show-updating $! System
	dunstify -u low "Yay Finished" "System packages are up to date" -t 2000 -i check-filled
	flatpak update
	show-updating $! Flatpak
	dunstify -u low "Flatpak Finished" "Flatpaks are up to date" -t 2000 -i check-filled
}

check() {
	while ! ping -c 1 archlinux.org &>/dev/null; do
		true
	done

	local NOTIFICATION_SENT=/tmp/update_notif
	local OFFICIAL_UPDATES=$(checkupdates | wc -l)
	local AUR_UPDATES=$(yay -Qua | wc -l)
	local UPDATE_COUNT=$((OFFICIAL_UPDATES + AUR_UPDATES))

	local URGENCY="low"
	[[ $UPDATE_COUNT -gt 50 ]] && URGENCY="critical"

	[[ $UPDATE_COUNT -eq 0 ]] && [[ -e $NOTIFICATION_SENT ]] && rm $NOTIFICATION_SENT

	[[ $UPDATE_COUNT -gt 1 ]] && PLURAL="s"

	[[ $UPDATE_COUNT -gt 0 ]] && [[ ! -e $NOTIFICATION_SENT ]] && dunstify "$UPDATE_COUNT update$PLURAL available" "$OFFICIAL_UPDATES from pacman $AUR_UPDATES from AUR" -u $URGENCY -i edit-download && touch $NOTIFICATION_SENT
	echo "$UPDATE_COUNT"
}

which yay &>/dev/null || exit 1
which checkupdates &>/dev/null || exit 1

case "$1" in
check)
	check
	;;
update)
	update
	;;
*)
	echo invalid argument lmao
	;;
esac
