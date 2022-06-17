#!/bin/sh

#Switch caps lock to ctrl
setxkbmap -option caps:ctrl_modifier &

userresources=$HOME/.Xresources

export PATH=${PATH}:${HOME}/.local/bin::${HOME}/.local/bin/sb-scripts
export BW_SESSION="oS6OJQ906Mja0k/ILGkyLYb/L9tUJXGtbgOO8CtKB0mlmlSlY57PoH/Ex7BVLMHj7atsRYTYfILHMHN2lENBZQ=="
# merge in defaults and keymaps
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Dual monitor setup
xrandr --output eDP-1 --primary --mode 1920x1080 --rotate normal --output HDMI-1 --rotate normal --right-of eDP-1 &

# Eye saver
redshift >/dev/null 2>&1 &

# Dwmblocks mpd and mpd update script
mpd >/dev/null 2>&1 &
sb-mpdup >/dev/null 2>&1 &

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
feh --bg-fill /home/$USER/Pictures/wallpapers/catppuccin/exodus_v01.png >/dev/null 2>&1 &


# Dwm Loop
while true; do 
	dwm >/dev/null 2>&1
done


# Dwm
exec dwm
