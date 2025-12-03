#!/usr/bin/env bash

case "$XDG_CURRENT_DESKTOP" in
niri)
	niri msg action show-hotkey-overlay
	;;
Hyprland)
	hyprland-keybinds.sh
	;;
*)
	echo "Didn't implement for this compositor yet"
	;;
esac
