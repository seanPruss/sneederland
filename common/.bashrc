#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
hyprpm list | grep hyprtrails &>/dev/null || hyprpm add https://github.com/hyprwm/hyprland-plugins &>/dev/null
hyprpm list | grep dynamic-cursors &>/dev/null || hyprpm add https://github.com/virtcode/hypr-dynamic-cursors &>/dev/null
hyprpm enable hyprtrails &>/dev/null
hyprpm enable dynamic-cursors &>/dev/null
source "$HOME"/.bash_colours
export MANPAGER='nvim +Man!'

exec nu
