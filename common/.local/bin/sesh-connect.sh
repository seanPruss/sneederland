#!/usr/bin/env bash
sesh connect "$(
	sesh list --icons | fzf --tmux 80% --reverse \
		--preview-window 'right:70%' \
		--preview 'sesh preview {}' \
		--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
		--header '  ^a sesh list ^d tmux kill ^f find' \
		--bind 'tab:down,btab:up' \
		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
		--bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)'
)"
