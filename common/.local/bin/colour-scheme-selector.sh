#!/usr/bin/env bash

COLOUR_SCHEMES=(rose-pine catppuccin)

SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | tofi --config "$HOME/.config/tofi/colour-scheme-switcher-config")

[[ -z $SELECTION ]] && exit
cd "$(fd -td sneederland $HOME)" || exit

rm -rf ~/Pictures/wallpapers/*
stow --override=.* --target=$HOME common
stow --override=.* --target=$HOME "dotfiles-$SELECTION"

case "$SELECTION" in
rose-pine)
	gsettings set org.gnome.desktop.interface gtk-theme "rose-pine-gtk"
	;;
catppuccin)
	gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-red-standard+default"
	;;
*)
	echo default
	;;
esac

killall hyprpaper && hyprctl dispatch exec hyprpaper
pypr reload
bat cache --build
