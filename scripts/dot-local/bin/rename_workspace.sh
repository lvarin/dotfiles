#!/bin/bash
#
# https://github.com/jeroenjanssens/i3-wm-scripts/blob/master/i3-rename-workspace
###############################################################################

MSG='i3-msg'
MSG='swaymsg'

OLD=$($MSG -t 'get_workspaces' | $MSG -t 'get_workspaces' | jq '.[] | select(.focused == true) | .name ' -r)
NEW=$(echo "$OLD" | wofi --dmenu --prompt="Rename workspace $OLD to:")

echo "rename workspace \"$OLD\" to \"$NEW\""
$MSG "rename workspace \"$OLD\" to \"$NEW\""
