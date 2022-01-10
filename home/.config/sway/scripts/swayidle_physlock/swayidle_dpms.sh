#!/usr/bin/env bash

swayidle -w\
	lock 'physlock -d'\
	timeout 30 "makoctl set-mode away"\
		resume "makoctl set-mode default"\
	timeout 180 'swaymsg "output * dpms off"'\
		resume 'swaymsg "output * dpms on"'\
	before-sleep 'playterctl -a pause; loginctl lock-session'\
	&> ~/.swayidle_log
