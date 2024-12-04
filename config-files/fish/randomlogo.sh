#!/bin/bash

rand=$((RANDOM % 3))

if [ $rand -eq 0 ]; then
	fastfetch
elif [ $rand -eq 1 ]; then
	colorscript random
else
	toilet -f ivrit 'I use Arch btw' | lolcat
fi
