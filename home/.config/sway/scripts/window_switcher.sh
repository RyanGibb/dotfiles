#!/usr/bin/env bash

windows=$(\
	swaymsg -t get_tree |\
	jq -r '
		recurse(.nodes[], .floating_nodes[];.nodes!=null)
		| select((.type=="con" or .type=="floating_con") and .name!=null)
		| "\(.id?) \(.window_properties.class? // .app_id?) - \(.name?)"
	'
)

selected=$(echo "$windows" | wofi -d -i -p "select window:" | awk '{print $1}')

swaymsg "[con_id="$selected"] focus"
