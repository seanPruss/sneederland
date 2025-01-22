#!/usr/bin/env bash

artist=$(playerctl -p spotify metadata artist | sed 's/&/&amp;/g')
title=$(playerctl -p spotify metadata title | sed 's/&/&amp;/g')
echo '{"text": "'"$artist - $title"'", "class": "custom-media", "alt": "Media"}'
