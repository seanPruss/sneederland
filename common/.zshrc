# Set up plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-you-should-use
zinit light MichaelAquilina/zsh-auto-notify
zinit light hlissner/zsh-autopair
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

AUTO_NOTIFY_IGNORE+=("sesh-connect" "yz" "cat")

random_logo() {
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
}

random_logo
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(pay-respects zsh)"
eval "$(starship init zsh)"

# Load stuff
autoload -Uz compinit && compinit
autoload -Uz edit-command-line
autoload -Uz add-zsh-hook
zle -N edit-command-line

zinit cdreplay -q

# keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -s '\es' 'sesh-connect^M'
bindkey '^x^e' edit-command-line

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# man pager
export MANPAGER='nvim +Man!'

# fzf options
export FZF_DEFAULT_OPTS='
  --color=fg:-1,bg:-1,hl:4
  --color=fg+:-1,bg+:-1,hl+:4
  --color=info:6,prompt:5,spinner:6,pointer:5,marker:2
'
export FZF_ALT_C_COMMAND="fd --strip-cwd-prefix --type directory --hidden --follow"
export FZF_ALT_C_OPTS="--height 40% --reverse --preview 'eza -A --tree --git-ignore {} | head -n 200'"
export FZF_CTRL_T_COMMAND="fd --strip-cwd-prefix --type file --hidden --follow"
export FZF_CTRL_T_OPTS="--height 40% --reverse --preview 'bat --color=always --style=full --line-range=:500 {}' "
export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --follow"

# bat theme
export BAT_THEME="base16"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview files with bat
zstyle ':fzf-tab:complete:*' fzf-preview 'bat --color=always --style=full --line-range=:500 $realpath'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always --git-ignore --group-directories-first $realpath'
# custom fzf flags
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
autopair-init

# Aliases
alias c="clear && random_logo"
alias ls="eza -A --icons=auto --group-directories-first"
alias ll="ls -lh --git"
alias tree="ls --tree --git-ignore"
alias v="nvim"
alias y="yay"
alias grep="grep --color=auto"
alias fd="fd --hidden"
alias locate="plocate"
alias rg="rg -p --hidden"
alias cat="bat -p"
alias fp="flatpak"
alias sd="sudo"
alias SS="sudo systemctl"
alias se="sudoedit"
alias lg="lazygit"
alias ld="lazydocker"
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
alias sl="ls"
alias xs="cd"
alias xsi="cdi"

# Functions
chpwd() {
    ls
}

auto_venv() {
    # If already in a virtualenv, do nothing
    if [[ -n "$VIRTUAL_ENV" && "$PWD" != *"${VIRTUAL_ENV:h}"* ]]; then
        deactivate
        return
    fi

    [[ -n "$VIRTUAL_ENV" ]] && return

    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/.venv/bin/activate" || -f "$dir/venv/bin/activate" ]]; then
            source "$dir/.venv/bin/activate" 2>/dev/null || source "$dir/venv/bin/activate"
            return
        fi
        dir="${dir:h}"
    done
}
add-zsh-hook chpwd auto_venv

mcd() {
    mkdir -p $1
    cd $1
}

up() {
    [ -z $1 ] && cd .. && return
    local DIR=".."
    if (($1 > 1)); then
        for _ in {2..$1}
        do
            DIR=$DIR/..
        done
    fi
    cd "$DIR"
}

yz() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && cd -- "$cwd"
    rm -f -- "$tmp"
}

sesh-connect() {
    sesh connect "$(
	sesh list --icons | fzf --tmux 80% --reverse \
		--preview-window 'right:70%' \
		--preview 'sesh preview {}' \
		--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
		--header '  ^a sesh list ^d tmux kill ^f find' \
		--bind 'tab:down,btab:up' \
		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
		--bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)')"
}
