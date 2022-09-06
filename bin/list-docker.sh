#!/bin/bash

ORG=$1

if [ -z "$ORG" ];
then
  echo "Use: $0 <ORGANIZATION>" >&2
  exit 1
fi

count=$(curl -s "https://hub.docker.com/v2/repositories/$ORG/" | jq .count)

echo -n "# We have '$count' repositories in '$ORG'"

i=1

while true; do
  curl -s "https://hub.docker.com/v2/repositories/$ORG/?page=$i" \
    | jq '.results | .[]| .name ' -r 2>/dev/null || exit 0
  i=$((i+1))
done
