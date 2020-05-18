#!/bin/bash
#

pactl set-default-sink bluez_sink.38_18_4C_84_61_7B.headset_head_unit

ACTION=$1

if [ -z "$ACTION" ];
then
  echo "Use: $0 <+5%|-5%|...>" >&2
  exit 1
fi

pactl set-sink-volume @DEFAULT_SINK@ "$ACTION"

