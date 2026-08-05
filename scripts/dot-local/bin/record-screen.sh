#!/bin/bash
#

ACTION=$1
ACTION=${ACTION,,}
STATE_FILE="/tmp/wf-recorder-outfile"

if [[ -z "$ACTION" ]]; then
  echo "Use: $0 <start/stop>"
fi

if [[ "start" == "$ACTION" ]]; then
  # Pick mode: full screen or region
  mode=$(yad --list \
    --title="Screen Recording" \
    --button=gtk-ok:0 \
    --button=gtk-cancel:1 \
    --column="Select Mode" \
    --height=200 --width=300 \
    "Full Monitor" \
    "Select Region" |
    tr -d '|')

  outfile="$HOME/Pictures/record-$(date +"%Y-%m-%d--%H-%M-%S").mp4"
  echo "$outfile" > "$STATE_FILE"

  if [[ "$mode" == "Full Monitor" ]]; then
    # Select monitor
    monitor=$(swaymsg -t get_outputs | jq -r '.[].name' |
      yad --list \
        --title="Select Monitor" \
        --button=gtk-ok:0 \
        --button=gtk-cancel:1 \
        --column="Monitor" \
        --height=200 --width=300 |
      tr -d '|')

    [ -z "$monitor" ] && exit 0

    # notify-send "📺 Recording monitor: $monitor"
    wf-recorder -o "$monitor" -a -f "$outfile"

  elif [[ "$mode" == "Select Region" ]]; then
    notify-send "📐 Select region to record"

    region=$(slurp)
    [ -z "$region" ] && exit 0

    wf-recorder -g "$region" -a -f "$outfile"
  else
    notify-send "Recording aborted"
  fi

elif [[ "stop" == "$ACTION" ]]; then
  outfile=$(cat "$STATE_FILE" 2>/dev/null || echo "unknown location")
  pkill -SIGINT wf-recorder && notify-send "🟥 Recording stopped. Stored at $outfile"
fi
