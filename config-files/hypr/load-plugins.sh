#!/bin/bash

if ! hyprpm list | grep hyprland-plugins; then
	hyprpm add https://github.com/hyprwm/hyprland-plugins
	hyprpm enable hyprwinwrap
	hyprpm enable hyprtrails
fi
