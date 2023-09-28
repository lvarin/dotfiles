#!/bin/bash
#
# https://github.com/jeroenjanssens/i3-wm-scripts/blob/master/i3-rename-workspace
###############################################################################

OLD=$(i3-msg -t 'get_workspaces' | i3-msg -t 'get_workspaces' | jq '.[] | select(.focused == true) | .name ' -r)
NEW=$(zenity --text="Enter new name:" --entry --title="Rename workspace $OLD" --entry-text="$OLD")

echo "rename workspace \"$OLD\" to \"$NEW\""
i3-msg "rename workspace \"$OLD\" to \"$NEW\""
