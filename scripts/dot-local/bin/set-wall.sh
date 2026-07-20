#!/usr/bin/env bash

# Directory with your images
DIR="$HOME/Pictures/Wallpapers"

# Temporary file to store selection
TMP_FILE="/tmp/sxiv_wallpaper"

# Find images (you can extend formats if needed)
IMAGES=$(find "$DIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.webp" \
\))

# Exit if no images found
[ -z "$IMAGES" ] && echo "No images found in $DIR" && exit 1

# Open sxiv in thumbnail mode (-t)
# -o prints selected file(s) to stdout
sxiv -to "$DIR"/* > "$TMP_FILE"

# Read selected image
SELECTED=$(cat "$TMP_FILE")

# Exit if nothing selected
[ -z "$SELECTED" ] && echo "No image selected" && exit 0

# Kill existing swaybg instances
pkill swaybg

# Set wallpaper
swaybg -i "$SELECTED" -m fit &

rm ~/Pictures/Wallpaper.jpg && ln -s "$SELECTED" ~/Pictures/Wallpaper.jpg

echo "Wallpaper set to: $SELECTED"
