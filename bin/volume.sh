#!/bin/bash
#

ACTION=$1

if [ -z "$ACTION" ];
then
  echo "Use: $0 <+5%|-5%|...>" >&2
  exit 1
fi

DEFAULT_SINK=$(pactl list sinks | grep ^Sink | head -1 | awk -F\# '{print $2}')

pactl set-sink-volume $DEFAULT_SINK "$ACTION"

VOL=$(pactl list sinks | egrep '[[:blank:]]Volume:' -w | awk '{print $5}' | head -1)

for s in $(pactl list sinks | grep Sink | awk -F\# '{print $2}');
do
  [[ $s -ne 0 ]] && pactl set-sink-volume $s $VOL
done
