#!/usr/bin/env bash

case "$XDG_CURRENT_DESKTOP" in
niri)
	niri msg action quit
	;;
Hyprland)
	uwsm stop
	;;
*)
	echo "Didn't implement for this compositor yet"
	;;
esac
