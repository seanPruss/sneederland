#!/usr/bin/env bash

yay -Syyu --noconfirm
dunstify "Yay Finished"
flatpak update
dunstify "Flatpak Finished"
