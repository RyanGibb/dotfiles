#!/usr/bin/env bash

sinks=($(pactl list short sinks | cut -f 2))
default_sink=$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')

for i in "${!sinks[@]}"; do
   if [[ "${sinks[$i]}" = "${default_sink}" ]]; then
      break
   fi
done

i=$(((i+1)%${#sinks[@]}))

pactl set-default-sink "${sinks[$i]}"
