#!/usr/bin/env bash

set -e

REMOTE="alvaro@192.168.8.128"
PREFIX="scan-$(date +%Y-%m-%d.%H.%M)"
COUNT=1

echo "📡 Connecting to $REMOTE"
echo "📁 Saving scans in $PWD"
FILE=""

while true; do

  ACTION=$(
    printf '%s\n' \
      "Scan page" \
      "Preview last scan (imv)" \
      "Browse all scans (imv)" \
      "Delete last scan" \
      "Finish and create PDF" \
      "Exit" |
     wofi --dmenu --sort-order=default --prompt "Scan"
  )
  case "$ACTION" in
  "Scan page")
    FILE=$(printf "%s_%03d.png" "$PREFIX" "$COUNT")

    notify-send "Scanning" "Scanning page $COUNT..."

    ssh "$REMOTE" "scanimage --format=png" >"$FILE"

    notify-send "Scan complete" "$FILE"

    ((COUNT++))
    ;;
  "Preview last scan (imv)")
    imv "$FILE"
    ;;
  "Browse all scans (imv)")
    imv -d "${PREFIX}"_*.png
    ;;
  "Delete last scan")
    notify-send "🗑️  Deleting last scan..."
    rm -f "$FILE"
    if ((COUNT > 1)); then
      ((COUNT--))
    fi
    ;;
  "Finish and create PDF")
    notify-send "📄 Creating PDF..."

    img2pdf "${PREFIX}"_*.png -o "${PREFIX}.pdf"

    notify-send "✅ PDF created: ${PREFIX}.pdf"
    break
    ;;
  "Exit")
    break
    ;;
  *)
    notify-send "❌ Invalid option"
    ;;
  esac
done

echo "🎉 Done!"
