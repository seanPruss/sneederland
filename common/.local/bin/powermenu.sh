#!/usr/bin/env bash
shutdown='󰐥'
reboot='󰜉'
lock=''
suspend='󰒲'
logout='󰍃'
CHOSEN=$(echo -e "$lock\n$suspend\n$reboot\n$shutdown\n$logout" | rofi -dmenu -theme power-menu.rasi)

case "$CHOSEN" in
"$lock") hyprlock ;;
"$suspend") systemctl suspend ;;
"$reboot") systemctl reboot ;;
"$shutdown") systemctl poweroff ;;
"$logout") hyprctl dispatch exit ;;
*) exit 1 ;;
esac
