#!/bin/bash
while true; do
	BATTERY_DISCHARGING=$(acpi -b | grep "Battery 0" | grep -c "Discharging")
	BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')
	if [ "$BATTERY_LEVEL" -le 25 ] && [ "$BATTERY_DISCHARGING" -eq 1 ]; then
		notify-send --urgency=CRITICAL "󱊡 Battery Low" "Level: ${BATTERY_LEVEL}%"
		sleep 300
	elif [ "$BATTERY_LEVEL" -gt 95 ] && [ "$BATTERY_DISCHARGING" -eq 0 ]; then
		notify-send --urgency=LOW "󰁹 Battery High" "Level: ${BATTERY_LEVEL}%"
		sleep 300
	else
		sleep 120
	fi
done
