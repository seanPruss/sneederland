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
fi

fastfetch --load-config examples/10.jsonc
source ~/.config/zsh/git.zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
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

# Aliases

# Clear screen and neofetch
nf ()
{
    clear
    neofetch
}
# sudo alias because why not
alias fucking="sudo"

# yay aliases
alias install="yay -S --noconfirm"
alias uninstall="yay -Rns --noconfirm"
alias search="yay -Ss"

# ls aliases
alias ls="eza -a --icons=auto"
alias ll="ls -lh --git --git-repos"
alias tree='eza --tree --git-ignore'
# declutter screen and ls
cls() {
    clear
    ls
}
cll() {
    clear
    ll
}

# better cd
cd() {
    # do we want to go home or to previous directory
    if [[ $1 = "" || $1 = "-" ]]; then
        z $1
    else
        # open interactive mode if arg is in zoxide database
        # NOTE: "zoxide: no match found" will be displayed if the argument is 
        # not in the database but z will still work and ls will run. Also if the
        # directory you want to cd into is inside cwd hit escape if interactive
        # menu pops up
        if ! zi $1; then
            z $1
        fi
    fi
    # If argument in zoxide database, use interactive option
	check_directory_for_new_repository
    ls # I have never seen anyone ever do a cd without also doing ls
}

# cd into a directory I just made
mcd() {
    mkdir -p $1
    cd $1
}

# cd aliases
alias b="cd .."
alias bb="cd ../.."
alias bbb="cd ../../.."
alias bbbb="cd ../../../.."
alias p="cd -"

# aliases for terminal apps
alias vim="nvim"
alias lzg='lazygit'
alias yz='yazi'
alias tp="btop"
btw() {
    clear
    toilet -f ivrit 'I use Arch btw' | lolcat
}

# zellij aliases
alias zla='zellij attach'
alias zls='zellij ls'

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
setopt hist_verify
setopt inc_append_history
setopt share_history

autoload -U compinit 
compinit
_comp_options+=(globdots)

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# plugins
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh/plugins/zsh-autoswitch-virtualenv/zsh-autoswitch-virtualenv.plugin.zsh
source /usr/share/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
source /usr/share/zsh/plugins/zsh-directory-history/zsh-directory-history.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
AUTO_NOTIFY_IGNORE+=("lazygit" "crontab -e" "yazi" "zellij" "cmatrix" "sudoedit" "git log" "cd" "cava")

if [[ -f /etc/bash.command-not-found ]]; then
    . /etc/bash.command-not-found
fi

zstyle ':completion:*' menu select

# history substring search options
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
