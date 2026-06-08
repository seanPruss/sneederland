export TERMINAL=kitty
export BROWSER=helium-browser
export EDITOR=nvim
export VISUAL=nvim
export PNPM_HOME=$HOME/.local/share/pnpm
export PATH=$HOME/.local/bin:/usr/lib/docker/cli-plugins:$PNPM_HOME:$HOME/.cargo/bin:$PATH
tmux ls &>/dev/null || tmux new-session -d
