#!/usr/bin/env bash

rand=$((RANDOM % 8))
FONT=$(ls /usr/share/figlet/ | sed -r '/_/d; s/\..*//' | shuf -n 1)

if [ $rand -eq 0 ] || [ $rand -eq 4 ]; then
	fastfetch
elif [ $rand -eq 1 ] || [ $rand -eq 5 ]; then
	colorscript random
elif [ $rand -eq 2 ]; then
	toilet -t -f "$FONT" 'I use Arch btw' --rainbow
elif [ $rand -eq 3 ]; then
	toilet -t -f "$FONT" 'The Sneed Machine' --rainbow
else
	fortune | cowsay -f "$(cowsay -l | shuf -n 1)"
fi

exit 0
