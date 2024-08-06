#!/bin/sh
xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal  &

function restart {
	if ps x | rg "$1" | awk '{print $1}'; then
		pkill -f $1
	fi
	$1 $2 $3 $4 &
}

xrdb ~/.Xresources &
restart dunst
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
dbus-update-activation-environment --all &
restart dbus-launch --sh-syntax
# feh --bg-fill ~/Pictures/Walls/green/everforest-forest.jpg &
betterlockscreen -w &
greenclip daemon &
# bash ~/.local/bin/status_updater.sh &
slstatus &
compfy --daemon 
udiskie -a &
xset -dpms
xset s 840 900 # dim at 14 min and lock at 15 min
xss-lock -n ~/.local/bin/notify-suspend -- betterlockscreen -l dimblur &
