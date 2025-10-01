#!/bin/bash
#
# https://github.com/jeroenjanssens/i3-wm-scripts/blob/master/i3-rename-workspace
###############################################################################

MSG='i3-msg'
MSG='swaymsg'

OLD=$($MSG -t 'get_workspaces' | $MSG -t 'get_workspaces' | jq '.[] | select(.focused == true) | .name ' -r)
NEW=$(yad --text="Enter new name:" --entry --title="Rename workspace $OLD" --entry-text="$OLD")

echo "rename workspace \"$OLD\" to \"$NEW\""
$MSG "rename workspace \"$OLD\" to \"$NEW\""
