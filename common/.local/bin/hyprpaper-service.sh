#!/usr/bin/env bash

systemctl --user enable --now hyprpaper.service
while ! systemctl --user status hyprpaper.service; do
	systemctl --user enable --now hyprpaper.service
done
