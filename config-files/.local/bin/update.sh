#!/usr/bin/env bash

show-updating() {
	local VALUE=0
	while ps | grep $1 &>/dev/null; do
		((VALUE == 100)) && ((VALUE = 0))
		dunstify -u low -r 9993 -h int:value:"$VALUE" -i "edit-download" "Updating" "$2 packages updating" -t 500
		((VALUE++))
	done
	echo -en " Done!\n"
	sleep 1
}

sudo touch /tmp/update.tmp
yay -Syyu --noconfirm &
show-updating $! Yay
dunstify -u low "Yay Finished" "System packages are up to date" -t 2000 -i check-filled
flatpak update
show-updating $! Flatpak
dunstify -u low "Flatpak Finished" "Flatpaks are up to date" -t 2000 -i check-filled
