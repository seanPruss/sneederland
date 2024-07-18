#!/bin/bash
yay -Syyu --noconfirm
flatpak update
notify-send "Updates Finished"
