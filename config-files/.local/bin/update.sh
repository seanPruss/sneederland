#!/usr/bin/env bash

yay -Syyu --noconfirm
dunstify -u low "Yay Finished" "System packages are up to date"
flatpak update
dunstify -u low "Flatpak Finished" "Flatpaks are up to date"
