#!/usr/bin/env bash
set -ex

if command -v pacman >/dev/null; then
    xargs -a packages/arch.txt sudo pacman -S --needed
elif command -v apt >/dev/null; then
    sudo apt update
    xargs -a packages/debian.txt sudo apt install -y
fi

./stow.sh
