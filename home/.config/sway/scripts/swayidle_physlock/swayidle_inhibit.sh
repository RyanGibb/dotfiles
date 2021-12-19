#!/usr/bin/env bash

swayidle -w\
	lock 'physlock -d'\
	timeout 30 "makoctl set-mode away"\
		resume "makoctl set-mode default"\
	before-sleep 'playterctl -a pause; loginctl lock-session'\
	&> ~/.swayidle_log

