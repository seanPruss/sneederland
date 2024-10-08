#!/bin/bash

hyprwinwrap-background() {
	kitty -c "$HOME/.config/kitty/kittyconfigbg.conf" --class="kitty-bg" "$HOME/.config/hypr/pipes-rs.sh" &
	kitty -c "$HOME/.config/kitty/kittyconfigbg.conf" --class="kitty-bg" "$HOME/.config/hypr/cmatrix.sh" &
	kitty -c "$HOME/.config/kitty/kittyconfigbg.conf" --class="kitty-bg" "$HOME/.config/hypr/cava.sh" &
}

update-hyprpm() {
	hyprpm update && hyprwinwrap-background
}

swaync &
waybar &
swww-daemon &
hyprctl setcursor rose-pine-hyprcursor 24
gsettings set org.gnome.desktop.interface cursor-theme BreezeX-RosePine-Linux
gsettings set org.gnome.desktop.interface cursor-size 24
hyprctl monitors | grep HDMI-A-1 && hyprctl dispatch workspace 2
while ! ping -c 1 archlinux.org; do
	true
done
update-hyprpm &
tldr --update &
hyprctl dispatch exec spotify
hyprctl dispatch exec vesktop
sleep 10
hyprctl dispatch closewindow Spotify
hyprctl dispatch closewindow vesktop
