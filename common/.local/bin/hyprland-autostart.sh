#!/usr/bin/env bash

start-gammastep() {
	local latitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 1)
	local longitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 2)
	hyprctl dispatch exec -- gammastep -t 6500:1500 -l $latitude:$longitude && notify-send -u low -i check-filled "Gammastep Started" "Night light will turn on at sunset"
}

check-repo-updates() {
	# Navigate to the local Git repository
	local REPO_DIR="$(fd -td sneederland $HOME)"
	cd "$REPO_DIR" || exit

	# Fetch the latest changes from the remote repository
	git fetch origin

	# Check if the local branch is behind the remote branch
	local LOCAL="$(git rev-parse @)"
	local REMOTE="$(git rev-parse @{u})"

	[ "$LOCAL" != "$REMOTE" ] && notify-send "Update available for SneederLand" "Run git pull in $REPO_DIR and run installer.sh" -u critical -i mintupdate-updates-available
}

hyprctl monitors | grep HDMI-A-1 && hyprctl dispatch workspace 2

while ! ping -c 1 archlinux.org; do
	true
done

check-repo-updates &
start-gammastep &
hyprctl dispatch exec -- flatpak run com.spotify.Client
hyprctl dispatch exec -- vesktop
sleep 10
hyprctl dispatch killactive
hyprctl dispatch killactive
