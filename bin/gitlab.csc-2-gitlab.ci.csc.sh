#!/bin/bash -ex

REPO=$1

if [ -z "$REPO" ];
then
  echo "Use: $0 <REPO_NAME>" >&2
  exit 1
fi

git clone --bare "git@gitlab.csc.fi:juhani.kataja/${REPO}.git"

cd "${REPO}.git"

git push "ssh://git@gitlab.ci.csc.fi:10022/compen/css/juhani.kataja/${REPO}.git" --mirror

