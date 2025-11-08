#!/usr/bin/env bash

echo "One more step to complete the installation. Enter your password below to install Hyprland plugins."
hyprpm update -v -s
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
hyprpm enable hyprscrolling
hyprpm enable hyprtrails
hyprpm enable dynamic-cursors
clear
echo "You can also autostart apps with ignition"
echo "Press SUPER+/ for keybindings"
hyprctl dispatch exec -- uwsm-app -- flatpak run io.github.flattool.Ignition
touch ~/.cache/post-install
tput setaf 5 bold
read -rep "Press any key to exit" -s -n 1
