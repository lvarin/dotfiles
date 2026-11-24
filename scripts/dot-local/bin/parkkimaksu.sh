#!/bin/bash

PLATE=SOE476

notify-send "Parking" "$(curl -s "https://parkkimaksu.fi/api/parkkimaksu/spaces?plateText=${PLATE}&plateCountry=FIN" | jq -r '.spaces[] as $s | $s.targets[] | "\($s.spaces) \(.hallName)"')"
