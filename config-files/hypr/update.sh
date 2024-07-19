#!/bin/bash
[[ -f ~/update.log ]] && rm ~/update.log
yay -Syyu --noconfirm &>>~/update.log
flatpak update &>>~/update.log
notify-send "Updates Finished"
