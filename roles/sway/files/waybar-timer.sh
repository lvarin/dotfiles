#!/usr/bin/env bash

STATE="$HOME/.cache/waybar-timer"
now=$(date +%s)

# init state
[ -f "$STATE" ] || echo "0" >"$STATE"

end=$(cat "$STATE")

case "$1" in
set)
  mins=$(printf "8:00\n5" | wofi --dmenu --prompt "Timer (min)")
  [ -z "$mins" ] && exit 0
  if [[ "$mins" == *:* ]]; then
    IFS=: read -r hours minutes <<<"$mins"
    echo "$hours $minutes"
    mins=$((hours * 60 + minutes))
  fi

  echo $((now + mins * 60)) >"$STATE"
  ;;
clear)
  echo "0" >"$STATE"
  ;;
*)
  if ((end <= now)); then
    if ((end > 0)); then
      echo "0" >$STATE
      notify-send "⏱ Timer finished" "Your timer has ended"
      .dotfiles/bin/alert.sh
    fi
    echo "⏱️"
  else
    seconds=$((end - now))

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
