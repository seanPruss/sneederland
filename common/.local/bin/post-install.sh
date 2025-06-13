#!/usr/bin/env bash

echo "One more step to complete the installation. Enter your password below to install and enable Hyprland plugins."
echo "If Hyprland crashes just turn off your computer and turn it back on lol hyprpm is weird like that"
hyprpm update -v -s
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
hyprpm enable hyprtrails
hyprpm enable dynamic-cursors
echo "You can also autostart apps with ignition"
hyprctl dispatch exec -- uwsm-app -- flatpak run io.github.flattool.Ignition
touch ~/.post-install
tput setaf 5 bold
read -rep "Press any key to exit" -s -n 1
