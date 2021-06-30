#!/usr/bin/env bash
PROMPT='Switch to workspace: '
NAME=$($(dirname "$0")/select_ws.sh "$PROMPT") || exit
swaymsg workspace \"$NAME\"
