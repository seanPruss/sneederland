$env.TERMINAL = "ghostty"
$env.BROWSER = "zen-browser"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
use std "path add"
path add "~/.local/bin"
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
