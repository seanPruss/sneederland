#!/bin/bash

while true; do
	spotify_status=$(playerctl -p spotify status 2>/dev/null)
	player_status=$(playerctl status 2>/dev/null)

	if [ "$spotify_status" = "Playing" ]; then
		artist=$(playerctl -p spotify metadata artist | sed 's/&/&amp;/g')
		title=$(playerctl -p spotify metadata title | sed 's/&/&amp;/g')
		echo '{"text": "'"$artist - $title"'", "class": "custom-media", "alt": "Media"}'
	elif [ "$player_status" = "Playing" ]; then
		artist=$(playerctl metadata artist | sed 's/&/&amp;/g')
		title=$(playerctl metadata title | sed 's/&/&amp;/g')
		echo '{"text": "'"$artist - $title"'", "class": "custom-media", "alt": "Media"}'
	else
		echo '{"text": "Paused", "class": "custom-media", "alt": "Media (Paused)"}'
	fi
	sleep 3
done
