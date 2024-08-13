fastfetch
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

eval "$(ssh-agent -s)" &>/dev/null
# Linux TTY colours (I doubt I will ever use this)
if [ "$TERM" = "linux" ]; then
	/bin/echo -e "
	\e]P0#191724
	\e]P1#eb6f92
	\e]P2#9ccfd8
	\e]P3#f6c177
	\e]P4#31748f
	\e]P5#c4a7e7
	\e]P6#ebbcba
	\e]P7#e0def4
	\e]P8#26233a
	\e]P9#eb6f92
	\e]PA#9ccfd8
	\e]PB#f6c177
	\e]PC#31748f
	\e]PD#c4a7e7
	\e]PE#ebbcba
	\e]PF#e0def4
	"
    clear
else
    export TERM="xterm-256color"
fi

source ~/.config/zsh/git.zsh
# fzf config
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

# bat config
export BAT_THEME=rose-pine

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HISTDUP=erase

# Aliases

# Clear screen and fastfetch
alias ff="clear && fastfetch"

# package manager aliases
alias y="yay"
alias fp="flatpak"

# ls aliases
alias ls="eza -a --icons=auto --group-directories-first"
alias ll="ls -lh --git --git-repos"
alias lt="ll --tree --git-ignore"
alias tree='eza --tree --git-ignore'
# declutter screen and ls
alias cls="clear && ls"
alias cll="clear && ll"

alias grep="rg --color=auto"

# better cd
cd() {
    # do we want to go home or to previous directory
    if [[ -z $1 || $1 = "-" ]]; then
        z $1
    else
        # NOTE: "zoxide: no match found" will be displayed if the argument is 
        # not in the database but z will still work and ls will run. Also if the
        # directory you want to cd into is inside cwd hit escape if interactive
        # menu pops up
        zi $1 || z $1
    fi
	check_directory_for_new_repository
    ls # I have never seen anyone ever do a cd without also doing ls
}

cd.() {
    cd "./$1"
}

alias mkdir="mkdir -pv"
# cd into a directory I just made
mcd() {
    mkdir $1
    cd. $1
}

# moving up directories
up() {
    local d=""
    local limit="$1"
    if [[ -z $limit ]] || [[ $limit -le 0 ]]; then
        limit=1
    fi
    for ((i=1;i<=limit;i++)); do
        d="../$d"
    done

    cd "$d" || echo "Couldn't go up $1 directores"
}
alias p="cd -"

# confirmation
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

# aliases for terminal apps
alias vim="nvim"
alias lzg='lazygit'
alias btw="clear && toilet -f ivrit 'I use Arch btw' | lolcat"

# zellij aliases
alias zlnew='zellij --session'
alias zla='zellij attach'
alias zls='zellij ls'
alias zldelete='zellij delete-session --force'

# update mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# typo aliases
alias cim='vim'
alias sl="ls"
alias xs="cd"
alias bwt="btw"

# misc
alias svba="source venv/bin/activate"

# options
unsetopt menu_complete
unsetopt flowcontrol
setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt correct
setopt nobeep
setopt extendedglob
setopt nocaseglob

autoload -U compinit
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1
autoload edit-command-line && zle -N edit-command-line
bindkey '^v' edit-command-line
zle-keymap-select() {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 == 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5q'
preexec() { echo -ne '\e[5 q' ;}

# plugins
source /usr/share/zsh/plugins/zsh-autoswitch-virtualenv/zsh-autoswitch-virtualenv.plugin.zsh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
zstyle ':completion:*' matcher_list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'bat -n --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --git-ignore --color=always $realpath'
AUTO_NOTIFY_IGNORE+=("lazygit" "crontab -e" "zellij" "cmatrix" "sudoedit" "git log" "cd" "cava")

if [[ -f /etc/bash.command-not-found ]]; then
    . /etc/bash.command-not-found
fi

bindkey "^f" autosuggest-execute
bindkey "^k" history-substring-search-up
bindkey "^j" history-substring-search-down
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/sonicboom_dark.omp.toml)"
