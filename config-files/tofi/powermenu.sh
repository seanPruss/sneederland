#!/usr/bin/env bash

CHOSEN=$(printf "Lock\nSuspend\nReboot\nShutdown\nLog Out" | tofi --config "$HOME"/.config/tofi/powermenu-config)

case "$CHOSEN" in
"Lock") lockscreen ;;
"Suspend") systemctl suspend ;;
"Reboot") reboot ;;
"Shutdown") poweroff ;;
"Log Out") hyprctl dispatch exit ;;
*) exit 1 ;;
esac
