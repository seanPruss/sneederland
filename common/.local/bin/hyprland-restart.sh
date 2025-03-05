#!/usr/bin/env bash

killall waybar
waybar &

killall dunst
dunst &
