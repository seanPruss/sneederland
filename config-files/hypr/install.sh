#!/bin/bash
sudo touch /tmp/sudo.tmp
read -rp $'Package(s) to install: ' PACKAGES
[[ -f ~/install.log ]] && rm ~/install.log
yay -S --noconfirm $PACKAGES &>>~/install.log
notify-send "Installation Finished"
export BAT_THEME=rose-pine
bat ~/install.log
