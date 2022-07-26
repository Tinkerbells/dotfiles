#!/bin/sh

userresources=$HOME/.Xresources

# zsh default config path
export ZDOTDIR=$HOME/.config/zsh

# merge in defaults
xrdb -merge "$userresources"

# Dual monitor setup
xrandr --output eDP1 --mode 1920x1080 --rotate normal --output HDMI1 --primary --rotate normal --right-of eDP1     

# Eye saver
redshift >/dev/null 2>&1 &

# Dwmblocks mpd and mpd update script
sb-mpdup >/dev/null 2>&1 &
mpd-notify >/dev/null 2>&1 &

# Suspend
xidlehook --not-when-audio --not-when-fullscreen --timer 1800 '/usr/local/bin/slock' '' >/dev/null 2>&1 &

# Compositor
picom --experimental-backends -b >/dev/null 2>&1 &

# Keybindings
sxhkd &

# Clipmanager
greenclip daemon >/dev/null 2>&1 &

# Wallpaper
feh --bg-fill $HOME/Pictures/Wallpapers/catppuccin/catppuccin-planet.png >/dev/null 2>&1 &
# Dwmblocks
dwmblocks >/dev/null 2>&1 &

# Dwm Loop
while true; do
    dwm >/dev/null 2>&1
done
