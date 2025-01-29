#!/usr/bin/env bash

COLOUR_SCHEMES=(rose-pine catppuccin)

update-colours() {
	[[ -z $1 ]] && exit
	cd "$(fd -td sneederland $HOME)" || exit
	rm -rf ~/Pictures/wallpapers/*
	stow --override=.* --target=$HOME common
	stow --override=.* --target=$HOME "dotfiles-$SELECTION"

	case "$1" in
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

	# reload everything that doesn't hot reload
	hyprctl reload
	tmux kill-server
}
case "$1" in
random)
	SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | shuf -n 1)
	update-colours $SELECTION
	;;
choose)
	SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | tofi --config "$HOME/.config/tofi/colour-scheme-switcher-config")
	update-colours $SELECTION
	;;
*)
	echo "invalid command"
	;;
esac
