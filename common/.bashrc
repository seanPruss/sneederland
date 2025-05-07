#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
source "$HOME"/.bash_colours
export MANPAGER='nvim +Man!'

exec nu
