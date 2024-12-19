#!/usr/bin/env bash

rand=$((RANDOM % 6))

if [ $rand -eq 0 ] || [ $rand -eq 4 ]; then
	fastfetch
elif [ $rand -eq 1 ] || [ $rand -eq 5 ]; then
	colorscript random
elif [ $rand -eq 2 ]; then
	toilet -t -f mono9 -F rainbow 'I use Arch btw'
elif [ $rand -eq 3 ]; then
	toilet -t -f mono9 -F rainbow 'The Sneed Machine'
fi
