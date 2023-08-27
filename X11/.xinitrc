#!/bin/sh
# Zsh default config path
export ZDOTDIR="$HOME/.config/zsh"

# Merge xresources
xresources="$XDG_CONFIG_HOME/X11/xresources"

xrdb -merge "$xresources"

# Speedy keys
xset r rate 200 50

# Lock while idle
# xidlehook --not-when-audio --not-when-fullscreen --timer 3600 'systemctl suspend' '' >/dev/null &

# Dual monitor setup
# xrandr --output DP-0 --primary --mode 2560x1440 --rotate normal --rate 165.00 --output HDMI-0 --mode 1920x1200 --rotate left --left-of DP-0 --rate 60.00 >/dev/null &
# xrandr --output DP-0 --primary --mode 2560x1440 --rotate normal --rate 165.00

# MPRIS control player daemon
playerctld daemon >/dev/null &

autostart="pipewire sb-keyup setbg redshift dwmblocks mpd mpd-notify sxhkd clipmenud dunst transmission-daemon" # add picom

# Start programs without output
for program in $autostart; do
	(pidof -s "$program" || pgrep "$program" >/dev/null) || "$program" &
done >/dev/null 2>&1

# Dwm Loop
while true; do
	dwm >/dev/null 2>&1
done
