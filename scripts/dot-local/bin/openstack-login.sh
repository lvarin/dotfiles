#!/bin/bash
DB_FILE=$HOME/Nextcloud/keepass/Database.kdbx
export OS_PASSWORD=$(keepassxc-cli show $DB_FILE csc/CSC_account -s -a Password)
