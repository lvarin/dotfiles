#!/usr/bin/env bash
PACKAGE=($1)

if [ -z "$PACKAGE" ];
then
	PACKAGE=(
		#git
		#zsh
		fish
		#tmux
		nvim
		sway
		waybar
		mako
		wofi
		foot
		scripts
	)
fi

set -euo pipefail

cd "$(dirname "$0")"
set -x
stow --target="$HOME" --dotfiles "${PACKAGE[@]}"
