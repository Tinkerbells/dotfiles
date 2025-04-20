#!/bin/sh
# Zsh default config path
export ZDOTDIR="$HOME/.config/zsh"

# Merge xresources
xresources="$XDG_CONFIG_HOME/X11/xresources"
xremap="$XDG_CONFIG_HOME/xremap/config.yml"
xremap "$xremap" >/dev/null &
xrdb -merge "$xresources"
export "$(dbus-launch)"
xset -dpms
xset s off

# Speedy keys
xset r rate 200 50

# MPRIS control player daemon
playerctld daemon >/dev/null &

autostart="mpd pipewire sb-keyup setbg redshift mpd-notify sxhkd clipmenud transmission-daemon dwmblocks" # add picom

# Start programs without output
for program in $autostart; do
  (pidof -s "$program" || pgrep "$program" >/dev/null) || "$program" &
done >/dev/null 2>&1

# while true; do
# done
dbus-run-session dwm
