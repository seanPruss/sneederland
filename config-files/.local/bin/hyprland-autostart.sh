#!/usr/bin/env bash

start-gammastep() {
	local latitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 1)
	local longitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 2)
	hyprctl dispatch exec -- gammastep -t 6500:1200 -l $latitude:$longitude && dunstify -u low -i check-filled "Gammastep Started" "Night light will turn on at sunset"
}

load-hyprland-plugins() {
	if ! hyprpm list | grep hyprland-plugins; then
		hyprpm add https://github.com/hyprwm/hyprland-plugins
		hyprpm enable hyprtrails
	fi
	hyprpm update --no-shallow
}

check-repo-updates() {
	# Navigate to the local Git repository
	local REPO_DIR="$(fd -td sneederland -a $HOME)"
	cd "$REPO_DIR" || exit

	# Fetch the latest changes from the remote repository
	git fetch origin

	# Check if the local branch is behind the remote branch
	local LOCAL="$(git rev-parse @)"
	local REMOTE="$(git rev-parse @{u})"

	[ "$LOCAL" != "$REMOTE" ] && dunstify "Update available for SneederLand" "Run git pull in $REPO_DIR and run installer.sh" -u critical -i edit-download
}

hyprctl dispatch exec hyprpaper
hyprctl dispatch exec battery-notify
hyprctl dispatch exec waybar
hyprctl dispatch exec pypr
gsettings set org.gnome.desktop.interface cursor-theme "Banana"
gsettings set org.gnome.desktop.interface cursor-size 38
hyprctl monitors | grep HDMI-A-1 && hyprctl dispatch workspace 2

while ! ping -c 1 archlinux.org; do
	true
done

check-repo-updates &
start-gammastep &
load-hyprland-plugins &
hyprctl dispatch exec -- tldr --update
hyprctl dispatch exec spotify-launcher
hyprctl dispatch exec vesktop
sleep 8
hyprctl dispatch killactive
hyprctl dispatch killactive
