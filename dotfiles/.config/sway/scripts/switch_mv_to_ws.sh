#!/usr/bin/env bash
PROMPT='Move and switch to workspace: '
ID="$($(dirname "$0")/get_cur_focus_id.sh)"
NAME=$($(dirname "$0")/select_ws.sh "$PROMPT") || exit
$(dirname "$0")/focus_on_id.sh "$ID"
swaymsg move container to workspace \"$NAME\"
swaymsg workspace \"$NAME\"
$(dirname "$0")/focus_on_id.sh "$ID"
