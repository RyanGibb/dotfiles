#!/usr/bin/env bash

windows=$(swaymsg -t get_tree | jq -r '.nodes[1].nodes[].nodes[] | .. | (.id|tostring) + " " + .name?' | grep -e "[0-9]* ."  )

selected=$(echo "$windows" | wofi -d -i -p "select window:" | awk '{print $1}')

swaymsg "[con_id="$selected"] focus"
