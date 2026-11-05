#!/usr/bin/env bash

LAPTOP="eDP-1"

# Find the first active external monitor
EXTERNAL=$(swaymsg -t get_outputs | jq -r \
  '.[] | select(.active and .name != "eDP-1") | .name' | head -n1)

# Find the laptop
LAPTOP=$(swaymsg -t get_outputs | jq -r \
  '.[] | select(.active and .name == "eDP-1") | .name' | head -n1)


if [ -z "$EXTERNAL" ]; then
  notify-send "No external monitor found"
  exit 1
fi

# Choose the laptop screen position
POSITION=$(printf "← Left\n→ Right\n↓ Bottom\n" |
  fuzzel --dmenu --prompt "Laptop screen position")

# Cancel if no option was selected
[ -z "$POSITION" ] && exit 0

# Get external monitor geometry
EXT_POS=$(swaymsg -t get_outputs | jq -r \
  ".[] | select(.name==\"$EXTERNAL\") | .rect")

EXT_W=$(echo "$EXT_POS" | jq -r '.width')
EXT_H=$(echo "$EXT_POS" | jq -r '.height')

# Get external monitor geometry
LAP_POS=$(swaymsg -t get_outputs | jq -r \
  ".[] | select(.name==\"$LAPTOP\") | .rect")

LAP_W=$(echo "$LAP_POS" | jq -r '.width')
LAP_H=$(echo "$LAP_POS" | jq -r '.height')


# Position the screens
case "$POSITION" in
  "← Left")
    swaymsg output "$LAPTOP" position 0 0
    swaymsg output "$EXTERNAL" position "$LAP_W" 0
    notify-send "💻 Laptop screen to the left ←"
    ;;

  "→ Right")
    swaymsg output "$EXTERNAL" position 0 0
    swaymsg output "$LAPTOP" position "$EXT_W" 0
    notify-send "💻 Laptop screen to the right →"
    ;;

  "↓ Bottom")
    swaymsg output "$EXTERNAL" position 0 0
    swaymsg output "$LAPTOP" position "$[EXT_H/2]" "$EXT_H"
    notify-send "💻 Laptop screen below ↓"
    ;;
esac
