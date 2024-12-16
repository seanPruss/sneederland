#!/usr/bin/env bash

waybar &
swaync &
swww-daemon &
pypr &
gsettings set org.gnome.desktop.interface cursor-theme "Banana"
gsettings set org.gnome.desktop.interface cursor-size 38
hyprctl monitors | grep HDMI-A-1 && hyprctl dispatch workspace 2
while ! ping -c 1 archlinux.org; do
	true
done
hyprpm update --no-shallow &
tldr --update &
hyprctl dispatch exec spotify-launcher
hyprctl dispatch exec vesktop
sleep 10
hyprctl dispatch closewindow Spotify
hyprctl dispatch closewindow vesktop
