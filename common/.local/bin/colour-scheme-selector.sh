#!/usr/bin/env bash

COLOUR_SCHEMES=(rose-pine catppuccin)

SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | tofi --config "$HOME/.config/tofi/colour-scheme-switcher-config")

cd $(fd -td sneederland $HOME) || exit

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

pypr reload
bat cache --build
