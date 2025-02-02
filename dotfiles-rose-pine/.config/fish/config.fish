# ▄▄▄▄▄▄▄▄     ██               ▄▄        ▄▄▄▄▄▄       ▄▄▄▄
# ██▀▀▀▀▀▀     ▀▀               ██        ██▀▀▀▀██   ██▀▀▀▀█
# ██         ████     ▄▄█████▄  ██▄████▄  ██    ██  ██▀
# ███████      ██     ██▄▄▄▄ ▀  ██▀   ██  ███████   ██
# ██           ██      ▀▀▀▀██▄  ██    ██  ██  ▀██▄  ██▄
# ██        ▄▄▄██▄▄▄  █▄▄▄▄▄██  ██    ██  ██    ██   ██▄▄▄▄█
# ▀▀        ▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀   ▀▀    ▀▀  ▀▀    ▀▀▀    ▀▀▀▀

# Environment variables
set -Ux fish_user_paths $HOME/.local/bin $fish_user_paths
set -Ux TERMINAL ghostty
set -Ux BROWSER zen-browser
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -Ux BAT_THEME rose-pine

# Variables for fzf
set -Ux FZF_DEFAULT_OPTS "--color=fg:#908caa,bg:#191724,hl:#ebbcba --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba --color=border:#403d52,header:#31748f,gutter:#191724 --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52 --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
set -Ux FZF_FIND_FILE_COMMAND "fd --type=f --hidden --strip-cwd-prefix --exclude .git"
set -Ux FZF_CD_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"
set -Ux FZF_CD_OPTS "--height 40% --reverse"
set -Ux FZF_COMPLETE 3
set -Ux FZF_LEGACY_KEYBINDINGS 0
set -Ux FZF_COMPLETE_OPTS "--height 40%"
set -Ux FZF_REVERSE_ISEARCH_OPTS "--height 40%"
set -Ux FZF_PREVIEW_DIR_CMD "eza -A --tree --color=always --git-ignore --group-directories-first"
set -Ux FZF_PREVIEW_FILE_CMD "bat -n --color=always --line-range :500"

# Read man pages in neovim
set -Ux MANPAGER 'nvim +Man!'

# RC
if status is-interactive
    tmux ls &>/dev/null || tmux new-session -d
    randomlogo.sh
    fish_config theme choose "Rosé Pine"
    zoxide init fish | source
    set fish_greeting

    bind \eb prevd-or-backward-word
    bind \ef nextd-or-forward-word

    # Aliases for builtins
    abbr -a c "clear && randomlogo.sh"
    alias ls="eza -A --icons=auto --group-directories-first"
    alias tree='eza -A --tree --git-ignore --group-directories-first'
    alias mkdir='mkdir -pv'
    alias fd='fd --hidden'
    alias vim='nvim'
    alias locate='plocate'
    abbr -a cls "clear && ls"
    abbr -a cll "clear && ll"
    abbr -a fzf "fzf --height 40% --reverse"

    # Type less letters
    abbr -a v vim
    abbr -a y yay
    abbr -a fp flatpak
    abbr -a sd sudo
    abbr -a SS "sudo systemctl"
    abbr -a se sudoedit

    # Git aliases
    abbr -a lzg lazygit
    abbr -a gp 'git push'
    abbr -a gc 'git commit -m'
    abbr -a gco 'git checkout'
    abbr -a ga 'git add'
    abbr -a gb 'git branch'
    abbr -a gba 'git branch --all'
    abbr -a gbd 'git branch -D'
    abbr -a gcp 'git cherry-pick'
    abbr -a gd 'git diff -w'
    abbr -a gds 'git diff -w --staged'
    abbr -a grs 'git restore --staged'
    abbr -a gst 'git rev-parse --git-dir > /dev/null 2>&1 && git status || ls'
    abbr -a gu 'git reset --soft HEAD~1'
    abbr -a gpr 'git remote prune origin'
    abbr -a gpl 'git pull'
    abbr -a grd 'git fetch origin && git rebase origin/master'
    abbr -a gbb git-switchbranch
    abbr -a gbf 'git branch | head -1 | xargs' # top branch
    abbr -a gl "git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(green)%an %ar %C(reset) %C(bold magenta)%d%C(reset)'"
    abbr -a gla "git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'"
    abbr -a git-current-branch "git branch | grep \* | cut -d ' ' -f2"
    abbr -a grc 'git rebase --continue'
    abbr -a gra 'git rebase --abort'
    abbr -a gec 'git status | grep "both modified:" | cut -d ":" -f 2 | trim | xargs nvim -'
    abbr -a gcan 'gc --amend --no-edit'
    abbr -a gpf 'git push --force-with-lease'
    abbr -a gbdd 'git-branch-utils -d'
    abbr -a gbuu 'git-branch-utils -u'
    abbr -a gbrr 'git-branch-utils -r -b develop'
    abbr -a gg 'git branch | fzf | xargs git checkout'
    abbr -a gup 'git branch --set-upstream-to=origin/$(git-current-branch) $(git-current-branch)'
    abbr -a gnext 'git log --ancestry-path --format=%H ${commit}..master | tail -1 | xargs git checkout'
    abbr -a gprev 'git checkout HEAD^'

    # update mirrors
    abbr -a mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    abbr -a mirrord "sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    abbr -a mirrors "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    abbr -a mirrora "sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

    # typo aliases
    abbr -a sl ls
    abbr -a xs cd

    function starship_transient_prompt_func
        starship module character
    end
    function starship_transient_rprompt_func
        starship module time
    end
    starship init fish | source
    enable_transience
end
