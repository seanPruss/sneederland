#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
hyprpm list | grep hyprtrails || hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm list | grep dynamic-cursors || hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
hyprpm enable hyprtrails
hyprpm enable dynamic-cursors
source "$HOME"/.bash_colours
export MANPAGER='nvim +Man!'

exec nu
