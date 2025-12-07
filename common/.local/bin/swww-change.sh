#!/usr/bin/env bash

head -n 4 ~/.local/state/waypaper/state.ini >~/.local/state/waypaper/state.ini.temp
cat ~/.local/state/waypaper/state.ini.temp >~/.local/state/waypaper/state.ini
rm ~/.local/state/waypaper/state.ini.temp
waypaper --random --backend swww
