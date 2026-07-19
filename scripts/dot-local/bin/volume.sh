#!/bin/bash
#

function isMuted() {
  SINK=$1

  [[ "$(pactl get-sink-mute $SINK | awk '{print $2}')" == 'yes' ]] && return 0

  return 1
}

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
  if [[ "$ACTION" == "toggle" ]];
  then
    [[ $s -ne 0 ]] && pactl set-sink-mute $s toggle
  else
    [[ $s -ne 0 ]] && pactl set-sink-volume $s $VOL
  fi
done

if isMuted $DEFAULT_SINK;
then
  notify-send -t 1000 -a 'wp-vol' "🔇 MUTED"
else
  notify-send -t 1000 -a 'wp-vol' -h int:value:$VOL "${VOL}" -i /usr/share/icons/Paper/48x48/apps/volume-knob.png
fi
