#!/bin/sh

userresources=$HOME/.Xresources

export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.local/bin/sb-scripts":$PATH
export PATH="$HOME/.local/share":$PATH
# merge in defaults and keymaps
xrdb -merge "$userresources"

# Dual monitor setup
xrandr --output eDP-1  --mode 1920x1080 --rotate normal --output HDMI-1 ---primary -rotate normal --right-of eDP-1 &

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
sxhkd >/dev/null 2>&1 &

# Clipmanager
greenclip daemon >/dev/null 2>&1 &

# Dwmblocks
dwmblocks &

# Wallpaper 
feh --bg-fill $HOME/Pictures/wallpapers/catppuccin/catppuccin-planet.png >/dev/null 2>&1 &

# Dwm Loop
while true; do 
	dwm >/dev/null 2>&1
done

