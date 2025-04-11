#!/usr/bin/env bash

run-gammastep() {
	local latitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 1)
	local longitude=$(curl -s https://ipinfo.io/loc | cut -d ',' -f 2)
	while true; do
		pgrep gammastep || gammastep -t 6500:1500 -l "$latitude":"$longitude"
	done
}

run-hyprpaper() {
	while true; do
		pgrep hyprpaper || hyprpaper && pypr wall next
	done
}

run-hyprpaper &
while ! ping -c 1 archlinux.org; do
	true
done
run-gammastep &
