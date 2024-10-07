#!/bin/bash

while true; do
	player_status=$(playerctl status 2>/dev/null)

	if [ "$player_status" = "Playing" ]; then
		artist=$(playerctl metadata artist | sed 's/&/&amp;/g')
		title=$(playerctl metadata title | sed 's/&/&amp;/g')
		echo '{"text": "'"$artist - $title"'", "class": "custom-media", "alt": "Media"}'
	elif [ "$player_status" = "Paused" ]; then
		echo '{"text": "Paused", "class": "custom-media", "alt": "Media (Paused)"}'
	fi
	sleep 3
done
