#!/bin/bash
#
RMD="$( git rev-parse --git-path 'rebase-merge/' )"

if [ ! -d $RMD ];
then
  echo "Rebase NOT in progress"
  exit 1
fi

( N=$( cat "${RMD}msgnum" ) && L=$( cat "${RMD}end" ) && echo "${N} / ${L}" ; )
