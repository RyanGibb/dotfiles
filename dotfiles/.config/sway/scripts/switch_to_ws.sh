#!/usr/bin/env bash
PROMPT='switch to workspace: '
NAME=$($(dirname "$0")/select_ws.sh "$PROMPT") || exit
swaymsg workspace \"$NAME\"
