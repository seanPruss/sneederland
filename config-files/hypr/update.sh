#!/usr/bin/env bash

yay -Syyu --noconfirm
notify-send "Yay Finished"
flatpak update
notify-send "Flatpak Finished"
