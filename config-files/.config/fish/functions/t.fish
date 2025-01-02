function t
    set session $(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '  '\
        --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
        --bind 'tab:down,btab:up' \
        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
        --bind 'ctrl-t:change-prompt(  )+reload(sesh list -t)' \
        --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' \
        --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
        --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
        --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list -t -c)'
    )
    [ -z "$session" ] && return
    sesh connect $session
end
