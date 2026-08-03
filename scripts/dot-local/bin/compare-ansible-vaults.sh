#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./compare-vault.sh branch1 branch2 path/to/vault.yml
# Example:
#   ./compare-vault.sh main feature secrets/group_vars/prod/vault.yml


FILE="${1:?Vault file path required}"
BRANCH1="${2:?First branch required}"
BRANCH2="${3:-main}"

TMP1=$(mktemp)
TMP2=$(mktemp)

cleanup() {
  rm -f "$TMP1" "$TMP2"
}
trap cleanup EXIT

echo "Decrypting $FILE from $BRANCH1..."
git show "${BRANCH1}:${FILE}" | ansible-vault view /dev/stdin > "$TMP1"

echo "Decrypting $FILE from $BRANCH2..."
git show "${BRANCH2}:${FILE}" | ansible-vault view /dev/stdin > "$TMP2"

echo
echo -e "Diff between \e[32m$BRANCH1\e[0m and \e[31m$BRANCH2\e[0m:"
echo
diff --color=always -y "$TMP1" "$TMP2" || true
