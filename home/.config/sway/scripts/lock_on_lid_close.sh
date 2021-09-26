#!/bin/bash

# lock if only monitor
if [ "$(swaymsg -t get_outputs | grep '"type": "output"' | wc -l)" = "1" ]; then
	swaylock -f -i ~/pictures/wallpapers/default
fi

