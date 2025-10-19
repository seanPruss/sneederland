#!/usr/bin/env bash

while ! systemctl --user enable --now hyprpaper.service; do
	true
done
