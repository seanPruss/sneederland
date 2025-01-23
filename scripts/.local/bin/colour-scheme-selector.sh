#!/usr/bin/env bash

COLOUR_SCHEMES=(rose-pine catpuccin)

SELECTION=$(printf '%s\n' "${COLOUR_SCHEMES[@]}" | tofi)

cd $(fd -td sneederland $HOME) || exit

stow --override=.* --target=$HOME "dotfiles-$SELECTION"
hyprctl reload
