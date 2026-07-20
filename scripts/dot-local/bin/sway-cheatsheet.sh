#!/usr/bin/env bash

CONFIG="${1:-$HOME/.config/sway/config}"

# When not running in a terminal, relaunch in a kitty floating window
if [[ ! -t 1 ]]; then
  exec kitty --class sway-cheatsheet --title "Sway Cheatsheet" \
    bash -c "\"$0\" $(printf '%q' "$CONFIG")"
fi

if [[ ! -f "$CONFIG" ]]; then
  echo "Config file not found: $CONFIG" >&2
  exit 1
fi

MOD=$(grep -E '^set \$mod' "$CONFIG" | awk '{print $3}')
[[ -z "$MOD" ]] && MOD="\$mod"

{
  printf '\033[1;34m### Sway Keybinding Cheat Sheet ###\033[0m\n\n'
  grep -E '^\s*bindsym' "$CONFIG" | while read -r line; do
    clean=$(echo "$line" | sed 's/#.*//')
    key=$(echo "$clean" | sed -E 's/.*bindsym ([^ ]+) .*/\1/')
    action=$(echo "$clean" | sed -E 's/.*bindsym [^ ]+ (.*)/\1/')
    key_display=$(echo "$key" | sed "s/\$mod/$MOD/g")
    printf '\033[1;32m%-30s\033[0m %s\n' "$key_display" "$action"
  done
} | less -R
