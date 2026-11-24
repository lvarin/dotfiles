#!/usr/bin/env bash
set -euo pipefail

notify() {
    command -v notify-send >/dev/null && notify-send "SMB Mount" "$1"
}

if [ -t 0 ]; then
    read -rsp "KeePass password: " KP_PASS
    echo
else
    KP_PASS=$(fuzzel --dmenu --password --prompt-only="KeePass password: ") || exit 0
fi

[ -z "$KP_PASS" ] && exit 0

DB_PATH="$HOME/Nextcloud/Home/keepass/Database.kdbx"
ENTRY_PATH="csc/internal"   # Path to your SMB entry inside KeePassXC
MOUNT_POINT="/mnt/smbshare"

# Prompts for your KeePassXC master password, then extracts username & password
USER=$(printf '%s\n' "$KP_PASS" |keepassxc-cli show -a UserName "$DB_PATH" "$ENTRY_PATH")
PASS=$(printf '%s\n' "$KP_PASS" |keepassxc-cli show -s -a Password "$DB_PATH" "$ENTRY_PATH")
unset $KP_PASS

CRED_FILE=$(mktemp /dev/shm/cifs-cred.XXXXXX)
trap 'rm -f "$CRED_FILE"; unset KP_PASS PASS' EXIT
chmod 600 "$CRED_FILE"
printf 'username=%s\npassword=%s\n' "$USER" "$PASS" > "$CRED_FILE"

# 4. Authenticate sudo via stdin (-S) and mount
if printf '%s\n' "$KP_PASS" | sudo -S -p "" mount -t cifs $MOUNT_POINT -o credentials="$CRED_FILE"
then
    notify "Share mounted successfully."
else
    notify "Mount failed (check sudo password or network)."
    exit 1
fi

unset KP_PASS PASS
