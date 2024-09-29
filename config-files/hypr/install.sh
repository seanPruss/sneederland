#!/bin/bash
sudo touch /tmp/sudo.tmp
read -rep $'Package(s) to install: ' PACKAGES
yay -S --noconfirm $PACKAGES
notify-send "Installation Finished"
sleep 30
