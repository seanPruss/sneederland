CURRENT_SONG="mediaplayer.sh"
zscroll -p "   " --delay 0.6 \
	--length 20 \
	--match-command "playerctl -p spotify status" \
	--match-text "Playing" "--scroll 1" \
	--match-text "Paused" "--before-text '󰏤 ' --scroll 0" \
	--update-interval 1 \
	--update-check true "$CURRENT_SONG"
