$env.TERMINAL = "ghostty"
$env.BROWSER = "zen-browser"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.BAT_THEME = "rose-pine"
$env.FZF_DEFAULT_OPTS = "--color=fg:#908caa,bg:#191724,hl:#ebbcba --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba --color=border:#403d52,header:#31748f,gutter:#191724 --color=spinner:#f6c177,info:#9ccfd8,separator:#403d52 --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
use std "path add"
path add ~/.local/bin
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
