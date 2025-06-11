mkdir ~/.cache/starship
if ('~/.cache/starship/init.nu' | path exists) {
    true out+err> /dev/null
} else {
    starship init nu | save -f ~/.cache/starship/init.nu
}
if ('~/.zoxide.nu' | path exists) {
    true out+err> /dev/null
} else {
    zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
}
mkdir ~/.cache/carapace
if ('~/.cache/carapace/init.nu' | path exists) {
    true out+err> /dev/null
    } else {
    carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
}
