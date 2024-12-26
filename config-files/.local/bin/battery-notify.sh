#!/usr/bin/env bash

# Battery percentage at which to notify
WARNING_LEVEL=20
CRITICAL_LEVEL=5
CHARGED_LEVEL=99
while true; do
	BATTERY_DISCHARGING=$(acpi -b | grep "Battery 0" | grep -c "Discharging")
	BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

	# If the battery is charging and is full
	if [ "$BATTERY_LEVEL" -gt $CHARGED_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 0 ]; then
		dunstify "Battery Charged" "Battery is fully charged." -u low -i gpm-battery-000-charging -r 9991
		# If the battery is low and is not charging
	elif [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ]; then
		dunstify "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -u critical -i notification-battery-low -r 9991
		# If the battery is critical and is not charging
	elif [ "$BATTERY_LEVEL" -le $CRITICAL_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ]; then
		dunstify "Battery Critical" "The computer will shutdown soon." -u critical -i notification-battery-low -r 9991
	fi
	sleep 10
done
