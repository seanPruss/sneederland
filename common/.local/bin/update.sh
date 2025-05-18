#!/usr/bin/env bash

update() {
	if yay -Syyu --noconfirm; then
		notify-send -u low "Yay Finished" "System packages are up to date" -t 2000 -i check-filled
	else
		notify-send -u critical "Yay Failed" "System update failed" -t 2000 -i emblem-unreadable
	fi
	if flatpak update; then
		notify-send -u low "Flatpak Finished" "Flatpaks are up to date" -t 2000 -i check-filled
	else
		notify-send -u critical "Flatpak Failed" "Flatpak update failed" -t 2000 -i emblem-unreadable
	fi
	tput setaf 5 bold
	read -rep "Press any key to exit" -s -n 1
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

	[[ $UPDATE_COUNT -gt 0 ]] && [[ ! -e $NOTIFICATION_SENT ]] && notify-send "$UPDATE_COUNT update$PLURAL available" "$OFFICIAL_UPDATES from pacman $AUR_UPDATES from AUR" -u $URGENCY -i mintupdate-updates-available && touch $NOTIFICATION_SENT
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
