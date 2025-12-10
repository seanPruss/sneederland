#!/usr/bin/env bash
shutdown='󰐥'
reboot='󰜉'
lock=''
suspend='󰒲'
logout='󰍃'
CHOSEN=$(echo -e "$lock\n$suspend\n$reboot\n$shutdown\n$logout" | rofi -dmenu -i -theme power-menu.rasi)

case "$CHOSEN" in
"$lock") gtklock ;;
"$suspend") gtklock -L "systemctl suspend" ;;
"$reboot") systemctl reboot ;;
"$shutdown") systemctl poweroff ;;
"$logout") logout.sh ;;
*) exit 1 ;;
esac
