#!/usr/bin/env bash

killall waybar && hyprctl dispatch exec waybar

killall dunst && hyprctl dispatch exec dunst

pypr wall next
