try {tmux ls | null} catch {tmux new-session -d}
randomlogo.sh
source ~/.zoxide.nu
source ~/.cache/carapace/init.nu

$env.config = {
    show_banner: false

    ls: {
        use_ls_colors: true # use the LS_COLORS environment variable to colorize output
        clickable_links: true # enable or disable clickable links. Your terminal has to support links.
    }

    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    table: {
        mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: wrapping # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
        }
        header_on_separator: false # show header text on separator/border line
        # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
    }

    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages
}

# Aliases for builtins
alias ls = ls --all
alias ll = ls -l
def c [] {clear ;randomlogo.sh}
alias tree = eza -A --tree --git-ignore --group-directories-first
alias fd = fd --hidden
alias locate = plocate
def cls [] {clear ; ls}
def cll [] {clear ; ll}
alias fzf = fzf --height 40% --reverse

# Type less letters
alias v = vim
alias y = yay
alias fp = flatpak
alias sd = sudo
alias SS = sudo systemctl
alias se = sudoedit

# Git aliases
alias lzg = lazygit
alias gp = git push
alias gc = git commit -m
alias gco = git checkout
alias ga = git add
alias gb = git branch
alias gba = git branch --all
alias gbd = git branch -D
alias gcp = git cherry-pick
alias gd = git diff -w
alias gds = git diff -w --staged
alias grs = git restore --staged
alias gst = git status
alias gu = git reset --soft HEAD~1
alias gpr = git remote prune origin
alias gpl = git pull
def grd [] {git fetch origin; git rebase origin/master}
alias gbb = git-switchbranch
alias gbf = git branch | head -1 | xargs # top branch
alias gl = git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(green)%an %ar %C(reset) %C(bold magenta)%d%C(reset)'
alias gla = git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'
alias git-current-branch = git branch | grep \* | cut -d ' ' -f2
alias grc = git rebase --continue
alias gra = git rebase --abort
alias gec = git status | grep "both modified:" | cut -d ":" -f 2 | trim | xargs nvim -
alias gcan = gc --amend --no-edit
alias gpf = git push --force-with-lease
alias gbdd = git-branch-utils -d
alias gbuu = git-branch-utils -u
alias gbrr = git-branch-utils -r -b develop
alias gg = git branch | fzf | xargs git checkout
alias gprev = git checkout HEAD^

# update mirrors
alias mirror = sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist
alias mirrord = sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist
alias mirrors = sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist
alias mirrora = sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist

# Functions
def t [] {
    let session = (sesh list -t -c 
        | fzf 
        --height 40% 
        --reverse 
        --border-label ' sesh ' 
        --border 
        --prompt '  ' 
        --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' 
        --bind 'tab:down,btab:up' 
        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' 
        --bind 'ctrl-t:change-prompt(  )+reload(sesh list -t)' 
        --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' 
        --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' 
        --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' 
        --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list -t -c)'
    )

    if $session == "" {
        return
    }

    sesh connect $session
}

def --env yz [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

def mcd [...args] {
    mkdir args
    cd args
}

# typo aliases
alias sl = ls
alias xs = cd
alias xsi = cdi

# prompt
use ~/.cache/starship/init.nu
