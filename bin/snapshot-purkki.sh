#!/bin/bash
#
FOLDER="$HOME/Nextcloud/Home"

if [ -z "$FOLDER" ];
then
  echo "Cannot find $FOLDER, exiting" >&2
  exit 1
fi

SYNC_FOLDERS=".config .mozilla .thunderbird .docker .zsh .oh-my-zsh .zoom .urxvt src Music Videos Pictures Documents Templates"
SYNC_FILES=".zshrc .Xdefaults* .vault_pass.txt .zsh_history"

cd $HOME

for f in $SYNC_FOLDERS
do
  rsync -a "$f/" "$FOLDER/$f/"
done

for f in $SYNC_FILES
do
  cp "$f" "$FOLDER/"
done

