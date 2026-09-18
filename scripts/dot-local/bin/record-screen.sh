#!/bin/bash

ACTION="${1,,}"
STATE_FILE="/tmp/wf-recorder-outfile"

# If no action is specified, toggle based on state file
if [[ -z "$ACTION" ]]; then
  if [[ -f "$STATE_FILE" ]]; then
    ACTION="stop"
  else
    ACTION="start"
  fi
fi

if [[ "$ACTION" == "start" ]]; then
  # Pick mode: full screen or region
  mode=$(printf "Full Monitor\nSelect Region\n" |
    wofi --dmenu --prompt="Screen Recording")

  [ -z "$mode" ] && exit 0

  outfile="$HOME/Pictures/record-$(date +"%Y-%m-%d--%H-%M-%S").mp4"

  if [[ "$mode" == "Full Monitor" ]]; then
    # Select monitor
    monitor=$(swaymsg -t get_outputs | jq -r '.[].name' |
      wofi --dmenu --prompt="Select Monitor")

    [ -z "$monitor" ] && exit 0

    echo "$outfile" > "$STATE_FILE"

    wf-recorder -o "$monitor" -a -f "$outfile"

  elif [[ "$mode" == "Select Region" ]]; then
    notify-send "📐 Select region to record"

    region=$(slurp)
    [ -z "$region" ] && exit 0

    echo "$outfile" > "$STATE_FILE"

    wf-recorder -g "$region" -a -f "$outfile"

  else
    notify-send "Recording aborted"
  fi

elif [[ "$ACTION" == "stop" ]]; then
  outfile=$(cat "$STATE_FILE" 2>/dev/null || echo "unknown location")

  if pkill -SIGINT wf-recorder; then
    rm -f "$STATE_FILE"
    notify-send "🟥 Recording stopped. Stored at $outfile"
  else
    rm -f "$STATE_FILE"
    notify-send "⚠️ No recording process found"
  fi

else
  echo "Use: $0 [start|stop]"
  exit 1
fi
