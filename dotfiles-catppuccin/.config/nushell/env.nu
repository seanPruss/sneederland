$env.TERMINAL = "ghostty"
$env.BROWSER = "zen-browser"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.BAT_THEME = "catppuccin"
$env.FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --multi"
use std "path add"
path add "~/.local/bin"
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
