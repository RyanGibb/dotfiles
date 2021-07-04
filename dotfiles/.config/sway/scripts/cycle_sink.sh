#!/usr/bin/env bash

CACHE_FILE=.cache/pactl_sink_index

sinks=($(pactl list short sinks | cut -f 2))

i="$(cat $CACHE_FILE)"
if [[ "$i" == "" ]]; then
	default_sink=$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')

	for i in "${!sinks[@]}"; do
		if [[ "${sinks[$i]}" = "${default_sink}" ]]; then
			break
		fi
	done
fi

i=$(((i+1)%${#sinks[@]}))

echo "$i" > $CACHE_FILE

pactl set-default-sink "${sinks[$i]}"
