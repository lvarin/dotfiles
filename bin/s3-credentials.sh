#!/usr/bin/env bash
#
test -z $OS_AUTH_URL && echo "Quiting, no OS_AUTH_URL found" && exit 1

echo "Access                            Secret                            Name"
echo "-----------------------------------------------------------------------------------"
 jq -s '
  (.[0] | map({key: .ID, value: .}) | from_entries) as $first
  | .[1] | map($first[."Project ID"] + .)
  ' <(openstack project list -f json) \
    <(openstack ec2 credentials list -f json) | jq -r '[.[] | [.Access,.Secret,.Name]][] | @tsv' | column -t

