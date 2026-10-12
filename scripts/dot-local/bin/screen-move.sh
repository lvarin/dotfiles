#!/usr/bin/env bash

LAPTOP="eDP-1"
EXTERNAL=$(swaymsg -t get_outputs | jq -r \
  '.[] | select(.active and .name != "eDP-1") | .name' | head -n1)

if [ -z "$EXTERNAL" ]; then
  notify-send "No external monitor found"
  exit 1
fi

# Get current position of laptop output
POS=$(swaymsg -t get_outputs | jq -r \
  ".[] | select(.name==\"$LAPTOP\") | .rect")

X=$(echo "$POS" | jq -r '.x')
Y=$(echo "$POS" | jq -r '.y')

# Get external monitor geometry
EXT_POS=$(swaymsg -t get_outputs | jq -r \
  ".[] | select(.name==\"$EXTERNAL\") | .rect")

EXT_X=$(echo "$EXT_POS" | jq -r '.x')
EXT_Y=$(echo "$EXT_POS" | jq -r '.y')
EXT_W=$(echo "$EXT_POS" | jq -r '.width')
EXT_H=$(echo "$EXT_POS" | jq -r '.height')

# If laptop is below external ← move it to the left
if [[ "$Y" -gt "$EXT_Y" ]]; then
  swaymsg output "$LAPTOP" position 0  0
  swaymsg output "$EXTERNAL" position 1920  0
  notify-send "💻 Screen to the left ←"
elif [[ "$X" -lt "$EXT_X" ]]; then
  swaymsg output "$LAPTOP" position "$EXT_W" 0
  swaymsg output "$EXTERNAL" position 0 0
  notify-send "💻 Screen to the right →"
else
  # Otherwise move laptop below external
  swaymsg output "$LAPTOP" position "$(( EXT_X + EXT_H/2))" $((EXT_Y + EXT_H))
  swaymsg output "$EXTERNAL" position 0  0
  notify-send "💻 Screen is below now ↓"
fi
