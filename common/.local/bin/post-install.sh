#!/usr/bin/env bash

echo "One more step to complete the installation. Enter your password below to install and enable Hyprland plugins."
hyprpm update -v -s
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
hyprpm enable hyprtrails
hyprpm enable dynamic-cursors
touch ~/.post-install
tput setaf 5 bold
read -rep "Press any key to exit" -s -n 1
