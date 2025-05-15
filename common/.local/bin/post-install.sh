#!/usr/bin/env bash

echo "One more step to complete the installation. Enter your password below to install and enable Hyprland plugins."
hyprpm update -v -s
hyprpm add https://github.com/hyprwm/hyprland-plugins || exit
hyprpm add https://github.com/virtcode/hypr-dynamic-cursors || exit
hyprpm enable hyprtrails || exit
hyprpm enable dynamic-cursors || exit
touch ~/.post-install
