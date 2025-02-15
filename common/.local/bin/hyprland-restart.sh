#!/usr/bin/env bash

pgrep waybar && killall waybar && hyprctl dispatch exec waybar

pgrep dunst && killall dunst && hyprctl dispatch exec dunst

pgrep pypr && pypr reload
