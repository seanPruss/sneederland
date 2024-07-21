[[ -f ~/update.log ]] && rm ~/update.log
yay -Syyu --noconfirm &>>~/update.log
notify-send "Updates Finished"
export BAT_THEME=rose-pine
bat ~/update.log
