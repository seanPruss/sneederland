#!/bin/bash
yay -Syu --noconfirm
flatpak update
notify-send "Updates Finished"
