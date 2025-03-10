#!/usr/bin/env bash

COLOUR_SCHEMES=(rose-pine catppuccin dracula gruvbox tokyo-night)

update-colours() {
	[[ -z $1 ]] && exit
	cd "$(fd -td sneederland "$HOME")" || exit
	rm -rf ~/Pictures/wallpapers/*
	stow --override=.* --target="$HOME" "dotfiles-$1"
	stow --override=.* --target="$HOME" common

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
	gruvbox)
		gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Red-Dark"
		;;
	tokyo-night)
		gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark"
		;;
	*)
		echo "how tf did you get here"
		;;
	esac
	gsettings set org.gnome.desktop.interface icon-theme "BeautyLine"

	tmux kill-server
}
case "$1" in
random)
	SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | shuf -n 1)
	update-colours "$SELECTION"
	;;
choose)
	SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | tofi --config "$HOME/.config/tofi/colour-scheme-switcher-config" --fuzzy-match=true)
	update-colours "$SELECTION"
	;;
*)
	echo "invalid command"
	;;
esac
