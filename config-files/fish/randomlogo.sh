#!/bin/bash

rand=$((RANDOM % 4))

if [ $rand -eq 0 ]; then
	fastfetch
elif [ $rand -eq 1 ]; then
	colorscript random
elif [ $rand -eq 2 ]; then
	toilet -t -f mono9 -F rainbow 'I use Arch btw'
else
	toilet -t -f mono9 -F rainbow 'The Sneed Machine'
fi
