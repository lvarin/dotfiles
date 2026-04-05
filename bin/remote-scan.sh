#!/usr/bin/env bash

set -e

REMOTE="alvaro@192.168.8.128"
PREFIX="scan-$(date +%Y-%m-%d.%H.%M)"
COUNT=1

echo "📡 Connecting to $REMOTE"
echo "📁 Saving scans in $PWD"

while true; do

  ACTION=$(
    gum choose \
      "Scan page" \
      "Preview last scan (imv)" \
      "Browse all scans (imv)" \
      "Delete last scan" \
      "Finish and create PDF" \
      "Exit"
  )
  case "$ACTION" in
  "Scan page")
    FILE=$(printf "%s_%03d.png" "$PREFIX" "$COUNT")

    gum spin --spinner dot --title "🖨️  Scanning page $COUNT..." -- \
      ssh "$REMOTE" "scanimage --format=png" >"$FILE"

    ((COUNT++))
    ;;
  "Preview last scan (imv)")
    imv "$FILE"
    ;;
  "Browse all scans (imv)")
    imv -d "${PREFIX}"_*.png
    ;;
  "Delete last scan")
    echo "🗑️  Deleting last scan..."
    rm -f "$FILE"
    if ((COUNT > 1)); then
      ((COUNT--))
    fi
    ;;
  "Finish and create PDF")
    echo "📄 Creating PDF..."

    img2pdf "${PREFIX}"_*.png -o "${PREFIX}.pdf"

    echo "✅ PDF created: ${PREFIX}.pdf"
    break
    ;;
  "Exit")
    break
    ;;
  *)
    echo "❌ Invalid option"
    ;;
  esac
done

echo "🎉 Done!"
