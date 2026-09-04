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
  mode=$(printf "Full Monitor\nSelect Region\n" |
    wofi --dmenu --prompt="Screen Recording")

  outfile="$HOME/Pictures/record-$(date +"%Y-%m-%d--%H-%M-%S").mp4"
  echo "$outfile" > "$STATE_FILE"

  if [[ "$mode" == "Full Monitor" ]]; then
    # Select monitor
    monitor=$(swaymsg -t get_outputs | jq -r '.[].name' |
      wofi --dmenu --prompt="Select Monitor")

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
