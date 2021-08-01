#!/usr/bin/env bash
PROMPT='workspace name:'
DEFAULT=$($(dirname "$0")/get_cur_ws_name.sh)
NAME=$(zenity --entry --text "$PROMPT" --entry-text="$DEFAULT") || exit;

swaymsg rename workspace to \"$NAME\"
