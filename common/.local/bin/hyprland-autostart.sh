#!/usr/bin/env bash

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
if [ ! -e ~/.post-install ]; then
	ghostty --class=ghostty.postinstall -e post-install.sh
else
	hyprctl dispatch exec -- flatpak run com.spotify.Client
	hyprctl dispatch exec -- vesktop
	sleep 5
	hyprctl dispatch killactive
	hyprctl dispatch killactive
fi
