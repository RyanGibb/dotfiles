#!/usr/bin/env bash

swayidle -w\
	lock 'swaylock -f -i ~/pictures/wallpapers/default'\
	timeout 30 "makoctl set-mode away"\
		resume "makoctl set-mode default"\
	timeout 180 'swaymsg "output * dpms off"'\
		resume 'swaymsg "output * dpms on"'\
	timeout 240 'loginctl lock-session'\
	before-sleep 'playerctl -a pause; loginctl lock-session'\
	&> ~/.swayidle_log

