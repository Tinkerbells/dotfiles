#!/bin/sh

#Switch caps lock to ctrl
setxkbmap -option caps:ctrl_modifier &

userresources=$HOME/.Xresources

export PATH=${PATH}:${HOME}/.local/bin::${HOME}/.local/bin/sb-scripts
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

#Redshift 
redshift &

#Suspend 
xidlehook --not-when-audio --not-when-fullscreen --timer 1800 '/usr/local/bin/slock' '' &

#Compositor
picom --experimental-backends -b &

#Sxhkd 
sxhkd &

#Dwmblocks
sleep 10 && dwmblocks &

#Wallpaper 
feh --bg-fill ~/Pictures/wallpapers/landscapes/shaded_landscape.png &

#Loop
while true; do 
	dwm >/dev/null 2>&1
done

#Dwm
exec dwm
