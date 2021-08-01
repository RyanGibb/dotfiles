#!/usr/bin/env bash
swaymsg -t get_tree \
  | jq -r 'recurse(.nodes[];.nodes!=null) | select(.focused==true).id'