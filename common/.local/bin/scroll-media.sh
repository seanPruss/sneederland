CURRENT_SONG="mediaplayer.sh"
zscroll -p "   " --delay 0.2 \
	--length 25 \
	--match-command "playerctl -p spotify status" \
	--match-text "Playing" "--scroll 1" \
	--match-text "Paused" "--before-text '󰏤 ' --scroll 1" \
	--update-interval 1 \
	--update-check true "$CURRENT_SONG" &
