#!/usr/bin/env bash

while ! systemctl --user status hyprpaper.service; do
	systemctl --user enable --now hyprpaper.service
done
