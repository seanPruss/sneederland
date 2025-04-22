sesh connect "$(
	sesh list --icons | fzf --tmux 75%,80% \
		--preview-window 'right:70%' \
		--preview 'sesh preview {}' \
		--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
		--header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
		--bind 'tab:down,btab:up' \
		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
		--bind 'ctrl-t:change-prompt(  )+reload(sesh list --icons -t)' \
		--bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list --icons -c)' \
		--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list --icons -z)' \
		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
		--bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)'
)"
