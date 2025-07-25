#
# ~/.bash_profile
#
export TERMINAL=ghostty
export BROWSER=brave
export EDITOR=nvim
export VISUAL=nvim
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
export PATH=$PATH:$HOME/.local/bin:/usr/lib/docker/cli-plugins
[[ -f ~/.bashrc ]] && . ~/.bashrc
