#!/usr/bin/env bash
SONG_SCRIPT="mediaplayer.sh"
zscroll -p "" --delay 0.7 \
	--length 20 \
	--match-command "playerctl -p spotify status" \
	--match-text "Playing" "--scroll 1" \
	--match-text "Paused" "--before-text '󰏤 ' --scroll 1" \
	--update-interval 1 \
	--update-check true "$SONG_SCRIPT"
