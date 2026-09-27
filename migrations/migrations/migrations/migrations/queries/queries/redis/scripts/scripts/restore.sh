#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage:"
    echo "./scripts/restore.sh backups/capstone_YYYY-MM-DD.dump"
    exit 1
fi

BACKUP_FILE="$1"

dropdb --if-exists capstone_restore
createdb capstone_restore

pg_restore \
    -d capstone_restore \
    "$BACKUP_FILE"

echo "Restore completed successfully."
