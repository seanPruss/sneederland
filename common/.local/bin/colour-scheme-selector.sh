#!/usr/bin/env bash

COLOUR_SCHEMES=(rose-pine catppuccin dracula gruvbox tokyo-night nord)

update-colours() {
	[[ -z $1 ]] && exit
	cd "$(fd -td sneederland "$HOME")" || exit
	rm -rf ~/Pictures/wallpapers/*
	stow --no-folding --override=.* --target="$HOME" "dotfiles-$1"
	stow --no-folding --override=.* --target="$HOME" common

	rm -rf ~/.config/gtk-4.0
	case "$1" in
	rose-pine)
		gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
		gsettings set org.gnome.desktop.interface gtk-theme "rose-pine-gtk"
		ln -sf /usr/share/themes/rose-pine-gtk/gtk-4.0 ~/.config
		;;
	catppuccin)
		gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
		gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-red-standard+default"
		ln -sf ~/.local/share/themes/catppuccin-mocha-red-standard+default/gtk-4.0 ~/.config
		;;
	dracula)
		gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
		gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
		ln -sf /usr/share/themes/Dracula/gtk-4.0 ~/.config
		;;
	gruvbox)
		gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
		gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Red-Dark"
		ln -sf /usr/share/themes/Gruvbox-Red-Dark/gtk-4.0 ~/.config
		;;
	tokyo-night)
		gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
		gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark"
		ln -sf /usr/share/themes/Tokyonight-Dark/gtk-4.0 ~/.config
		;;
	nord)
		gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
		gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
		ln -sf /usr/share/themes/Nordic/gtk-4.0 ~/.config
		;;
	*)
		echo "how tf did you get here"
		;;
	esac
	gsettings set org.gnome.desktop.interface icon-theme "BeautyLine"
	nwg-look -x

	tmux kill-server
}
case "$1" in
random)
	SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | shuf -n 1)
	update-colours "$SELECTION"
	;;
choose)
	SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | rofi -dmenu -i)
	update-colours "$SELECTION"
	;;
*)
	echo "invalid command"
	;;
esac
