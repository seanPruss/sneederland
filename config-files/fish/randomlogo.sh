#!/bin/bash

rand=$((RANDOM % 4))

if [ $rand -eq 0 ]; then
	fastfetch
elif [ $rand -eq 1 ]; then
	colorscript random
elif [ $rand -eq 2 ]; then
	toilet -t -f ivrit 'I use Arch btw' -F rainbow
else
	toilet -t -f ivrit 'The Sneed Machine' -F rainbow
fi
