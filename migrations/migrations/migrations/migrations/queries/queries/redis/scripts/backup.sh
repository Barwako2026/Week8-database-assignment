#!/bin/bash

set -e

mkdir -p backups

DATE=$(date +%F)

pg_dump \
    -Fc \
    -f "backups/capstone_${DATE}.dump" \
    capstone

echo "Backup completed successfully."
echo "File: backups/capstone_${DATE}.dump"
