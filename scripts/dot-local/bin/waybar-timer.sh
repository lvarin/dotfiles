#!/usr/bin/env bash

STATE="$HOME/.cache/waybar-timer"
now=$(date +%s)

# init state
[ -f "$STATE" ] || echo "0" >"$STATE"

state=$(cat "$STATE")

case "$1" in
set)
  mins=$(printf "" | wofi --dmenu --prompt "Timer (min)")
  [ -z "$mins" ] && exit 0

  if [[ "$mins" == *:* ]]; then
    IFS=: read -r hours minutes <<<"$mins"
    mins=$((hours * 60 + minutes))
  fi

  echo $((now + mins * 60)) >"$STATE"
  ;;

pause)
  if [[ "$state" == paused:* ]]; then
    # Resume
    seconds=${state#paused:}
    echo $((now + seconds)) >"$STATE"
  elif ((state > now)); then
    # Pause
    seconds=$((state - now))
    echo "paused:$seconds" >"$STATE"
  fi
  ;;

clear)
  echo "0" >"$STATE"
  ;;

*)
  if [[ "$state" == paused:* ]]; then
    seconds=${state#paused:}

    if ((seconds >= 3600)); then
      hours=$((seconds / 3600))
      minutes=$(((seconds % 3600) / 60))
      secs=$((seconds % 60))
      printf '⏸ %d:%02d.%02d\n' "$hours" "$minutes" "$secs"
    else
      minutes=$((seconds / 60))
      secs=$((seconds % 60))
      printf '⏸ %d.%02d\n' "$minutes" "$secs"
    fi

  elif ((state <= now)); then
    if ((state > 0)); then
      echo "0" >"$STATE"
      notify-send "⏱ Timer finished" "Your timer has ended"
      "$HOME/.local/bin/alert.sh"
    fi
    echo "⏱️"

  else
    seconds=$((state - now))

    if ((seconds >= 3600)); then
      hours=$((seconds / 3600))
      minutes=$(((seconds % 3600) / 60))
      secs=$((seconds % 60))
      printf '⏳ %d:%02d.%02d\n' "$hours" "$minutes" "$secs"
    else
      minutes=$((seconds / 60))
      secs=$((seconds % 60))
      printf '⏳ %d.%02d\n' "$minutes" "$secs"
    fi
  fi
  ;;
esac
