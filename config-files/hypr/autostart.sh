#!/bin/bash

update-hyprpm() {
	hyprpm update --no-shallow && kitty -c "$HOME/.config/kitty/kittyconfigbg.conf" --class="kitty-bg" "$HOME/.config/hypr/cava.sh" &
}

swaync &
waybar &
swww-daemon &
pypr &
hyprctl setcursor "Banana" 38
gsettings set org.gnome.desktop.interface cursor-theme "Banana"
gsettings set org.gnome.desktop.interface cursor-size 38
hyprctl monitors | grep HDMI-A-1 && hyprctl dispatch workspace 2
while ! ping -c 1 archlinux.org; do
	true
done
update-hyprpm &
tldr --update &
hyprctl dispatch exec spotify-launcher
hyprctl dispatch exec vesktop
sleep 10
hyprctl dispatch closewindow Spotify
hyprctl dispatch closewindow vesktop
