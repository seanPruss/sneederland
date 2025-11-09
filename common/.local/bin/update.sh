#!/usr/bin/env bash

update() {
	if yay -Syyu --noconfirm --devel; then
		notify-send -u low "Yay Finished" "System packages are up to date" -i check-filled
	else
		notify-send -u critical "Yay Failed" "System update failed" -i emblem-unreadable
	fi
	if flatpak update -y; then
		notify-send -u low "Flatpak Finished" "Flatpaks are up to date" -i check-filled
	else
		notify-send -u critical "Flatpak Failed" "Flatpak update failed" -i emblem-unreadable
	fi
	tput setaf 5 bold
	read -rep "Press any key to exit" -s -n 1
}

check() {
	while ! ping -c 1 -W 1 8.8.8.8 &>/dev/null; do
		true
	done

	local NOTIFICATION_SENT=$HOME/.cache/update_notif
	local PACMAN_UPDATES=$(checkupdates | wc -l)
	local AUR_UPDATES=$(yay -Qua | wc -l)
	local FLATPAK_UPDATES=$(flatpak remote-ls --columns=application --updates | grep -v "Application ID" | wc -l)
	local UPDATE_COUNT=$((PACMAN_UPDATES + AUR_UPDATES + FLATPAK_UPDATES))

	local URGENCY="low"
	[[ $UPDATE_COUNT -gt 50 ]] && URGENCY="critical"

	[[ $UPDATE_COUNT -eq 0 ]] && [[ -e $NOTIFICATION_SENT ]] && rm $NOTIFICATION_SENT

	[[ $UPDATE_COUNT -gt 1 ]] && PLURAL="s"

	[[ $UPDATE_COUNT -gt 0 ]] && [[ ! -e $NOTIFICATION_SENT ]] && touch "$NOTIFICATION_SENT" && notify-send "$UPDATE_COUNT update$PLURAL available" "$PACMAN_UPDATES from pacman $AUR_UPDATES from AUR $FLATPAK_UPDATES from flatpak" -u $URGENCY -i mintupdate-updates-available
	echo "{\"text\":\"$UPDATE_COUNT\",\"tooltip\":\"Pacman: $PACMAN_UPDATES\nAUR: $AUR_UPDATES\nFlatpak: $FLATPAK_UPDATES\"}"
}

command -v yay &>/dev/null || exit 1
command -v checkupdates &>/dev/null || exit 1
command -v flatpak &>/dev/null || exit 1

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
