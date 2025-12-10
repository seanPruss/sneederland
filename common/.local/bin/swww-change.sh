#!/usr/bin/env bash

temp_file=$(mktemp)
head -n 4 ~/.local/state/waypaper/state.ini >"$temp_file"
mv "$temp_file" ~/.local/state/waypaper/state.ini
waypaper --random --backend swww
