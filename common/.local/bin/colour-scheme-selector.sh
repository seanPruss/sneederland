#!/usr/bin/env bash

COLOUR_SCHEMES=(rose-pine catppuccin dracula)

update-colours() {
	[[ -z $1 ]] && exit
	cd "$(fd -td sneederland $HOME)" || exit
	rm -rf ~/Pictures/wallpapers/*
	stow --override=.* --target=$HOME "dotfiles-$SELECTION"
	stow --override=.* --target=$HOME common

	case "$1" in
	rose-pine)
		gsettings set org.gnome.desktop.interface gtk-theme "rose-pine-gtk"
		;;
	catppuccin)
		gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-red-standard+default"
		;;
	dracula)
		gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
		;;
	*)
		echo "how tf did you get here"
		;;
	esac

	# reload everything that doesn't hot reload
	hyprctl reload
	sleep 1
	pypr wall next
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
