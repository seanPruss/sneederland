#!/usr/bin/env bash
shutdown='󰐥'
reboot='󰜉'
lock=''
suspend='󰒲'
logout='󰍃'
CHOSEN=$(echo -e "$lock\n$suspend\n$reboot\n$shutdown\n$logout" | rofi -dmenu -i -theme power-menu.rasi)

case "$CHOSEN" in
"$lock") gtklock ;;
"$suspend") gtklock -d && systemctl suspend ;;
"$reboot") systemctl reboot ;;
"$shutdown") systemctl poweroff ;;
"$logout") uwsm stop ;;
*) exit 1 ;;
esac
