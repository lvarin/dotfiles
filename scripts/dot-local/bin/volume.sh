#!/bin/bash

ACTION="$1"

if [[ -z "$ACTION" ]]; then
    echo "Use: $0 <+5%|-5%|toggle>" >&2
    exit 1
fi

SINK="@DEFAULT_AUDIO_SINK@"

case "$ACTION" in
    toggle)
        wpctl set-mute "$SINK" toggle
        ;;

    +*)
        wpctl set-volume "$SINK" "${ACTION#+}+"
        ;;

    -*)
        wpctl set-volume "$SINK" "${ACTION#-}-"
        ;;

    *)
        wpctl set-volume "$SINK" "$ACTION"
        ;;
esac

VOL=$(wpctl get-volume "$SINK" | awk '{print $2" * 100"}' | bc -l )

if [[ "$INFO" == *"[MUTED]"* ]]; then
    notify-send -t 1000 -a 'wp-vol' "🔇 MUTED"
else
    notify-send -t 1000 -a 'wp-vol' \
        -h "int:value:$VOL" \
        "${VOL}%" \
        -i /usr/share/icons/Paper/48x48/apps/volume-knob.png
fi
