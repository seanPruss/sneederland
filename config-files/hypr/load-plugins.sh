#!/usr/bin/env bash

if ! hyprpm list | grep hyprland-plugins; then
	hyprpm add https://github.com/hyprwm/hyprland-plugins
	hyprpm enable hyprtrails
fi
