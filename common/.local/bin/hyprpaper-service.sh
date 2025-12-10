#!/usr/bin/env bash

temp_file=$(mktemp)
head -n 4 ~/.local/state/waypaper/state.ini >"$temp_file"
mv "$temp_file" ~/.local/state/waypaper/state.ini
waypaper --random --backend hyprpaper
killall hyprpaper
systemctl --user enable --now hyprpaper.service
while ! systemctl --user status hyprpaper.service; do
	systemctl --user enable --now hyprpaper.service
done
