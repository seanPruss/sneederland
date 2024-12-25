#!/usr/bin/env bash

iDIR="$HOME/.local/share/icons/swaync"

# Get brightness percentage
get_backlight() {
	LIGHT=$(brightnessctl g)
	MAX_LIGHT=$(brightnessctl m)
	PERCENT=$(printf "%.0f" $(echo "$LIGHT/$MAX_LIGHT*100" | bc -l))
	echo "$PERCENT"
}

# Generate Brightness Bar
get_brightness_bar() {
	local brightness=$(get_backlight)
	local bar=""
	local total_bars=10
	local filled_bars=$((brightness * total_bars / 100))

	for ((i = 0; i < total_bars; i++)); do
		if ((i < filled_bars)); then
			bar+="█"
		else
			bar+="░"
		fi
	done

	echo "$bar"
}

# Get icons
get_icon() {
	local brightness=$(get_backlight)
	if [[ "$brightness" -le 20 ]]; then
		echo "$iDIR/brightness-20.png"
	elif [[ "$brightness" -le 40 ]]; then
		echo "$iDIR/brightness-40.png"
	elif [[ "$brightness" -le 60 ]]; then
		echo "$iDIR/brightness-60.png"
	elif [[ "$brightness" -le 80 ]]; then
		echo "$iDIR/brightness-80.png"
	else
		echo "$iDIR/brightness-100.png"
	fi
}

# Notify
notify_user() {
	local brightness=$(get_backlight)
	local bar=$(get_brightness_bar)
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Brightness : $brightness% $bar"
}

# Increase brightness
inc_backlight() {
	brightnessctl set 10%+ && notify_user
}

# Decrease brightness
dec_backlight() {
	brightnessctl set 10%- && notify_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_backlight
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi
