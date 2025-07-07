#!/bin/bash

function list_connected() {
  xrandr -q | grep -w connected | awk '{print $1}'
}

function list_active() {
  xrandr --listactivemonitors | awk '{print$4}' | grep -v ^$
}

function left_most() {
  xrandr --listactivemonitors | awk '{print$3,$4}' | grep -v '^\s*$' | sed -e 's#^[0-9]*/[0-9]*x[0-9]*/[0-9]*+\(.*\)+[0-9]*#\1#' | sort -k1 -n |  awk '{print $2}' | tail -1
}

function wallpaper() {
  feh --bg-fill ~/Pictures/Wallpaper.jpg
}

function enable() {
  CONN=$1

  message "Enabling $CONN"
  xrandr --output "$conn" --auto --right-of "$(left_most)"
}

function disable() {
  CONN=$1
  message "Disabling $CONN"

  xrandr --output "$CONN" --off
}

function message() {
  MSG=$1

  if [ -z "$MSG" ];
  then
    MSG='???'
  fi

  zenity --text="$MSG" --notification
  echo "$MSG"
}

CONNECTED="$(list_connected)"

ACTIVE="$(list_active)"

if [ "$ACTIVE" == "$CONNECTED" ];
then
  wallpaper
  message "Screens are all good"
  exit 0
fi

for act in $ACTIVE;
do
  echo "$CONNECTED" | grep -w -q "$act" || disable "$act"
done

for conn in $CONNECTED;
do
  echo "$ACTIVE" | grep -w -q "$conn" || enable "$conn"
done

wallpaper
exit 0
