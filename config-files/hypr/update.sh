#!/bin/bash
[[ -f ~/update.log ]] && rm ~/update.log
yay -Syyu --noconfirm &>>~/update.log
notify-send "Yay Finished"
flatpak update &>>~/update.log
notify-send "Flatpak Finished"
export BAT_THEME=rose-pine
bat ~/update.log
