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

MONITORS=$(hyprctl monitors | grep -c Monitor)
if ((MONITORS > 1)); then
	hyprctl dispatch workspace 2
fi

while ! ping -c 1 archlinux.org; do
	true
done

check-repo-updates &
[ ! -e ~/.post-install ] && ghostty --class=ghostty.postinstall -e post-install.sh
