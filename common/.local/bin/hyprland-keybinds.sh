#!/usr/bin/env bash
keybinds=$(grep -E '^bindd' ~/.config/hypr/common.conf | grep -v XF86 | grep -v bindm)

# check for any keybinds to display
if [[ -z "$keybinds" ]]; then
	echo "no keybinds found."
	exit 1
fi

# replace $mainmod with super in the displayed keybinds for rofi
display_keybinds=$(echo "$keybinds" | sed 's/\$mainMod/SUPER/g' | sed 's/bindd =//g' | awk -F , '{print $1" +" $2":" $3}')

# use rofi to display the keybinds with the modified content
echo "$display_keybinds" | rofi -dmenu -i
