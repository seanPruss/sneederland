#!/usr/bin/env bash

killall hyprpaper
systemctl --user enable --now hyprpaper.service
while ! systemctl --user status hyprpaper.service; do
	systemctl --user enable --now hyprpaper.service
done
