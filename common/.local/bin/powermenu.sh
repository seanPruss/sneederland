#!/usr/bin/env bash

CHOSEN=$(printf "Lock\nSuspend\nReboot\nShutdown\nLog Out" | tofi --config "$HOME"/.config/tofi/powermenu-config --fuzzy-match=true)

case "$CHOSEN" in
"Lock") hyprlock ;;
"Suspend") systemctl suspend ;;
"Reboot") systemctl reboot ;;
"Shutdown") systemctl poweroff ;;
"Log Out") hyprctl dispatch exit ;;
*) exit 1 ;;
esac
