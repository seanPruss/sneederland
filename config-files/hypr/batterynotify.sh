#!/bin/bash
while true; do
	bat_lvl=$(cat /sys/class/power_supply/BAT0/capacity)
	if [ "$bat_lvl" -le 25 ]; then
		notify-send --urgency=CRITICAL "Battery Low" "Level: ${bat_lvl}%"
		sleep 600
	elif [[ "$bat_lvl" -gt 95 ]]; then
		notify-send --urgency=LOW "Battery High" "Level: ${bat_lvl}%"
		sleep 600
	else
		sleep 120
	fi
done
