#!/bin/bash
# backup.sh - create tar.gz backup of chosen directory with rotation
source utils.sh || { echo "utils.sh not found"; exit 1; }

SRC_DIR="${1:-$HOME/Documents}"
DEST_DIR="${2:-$HOME/Backups}"
MAX_BACKUPS="${3:-7}"

DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$DEST_DIR/backup_$DATE.tar.gz"

mkdir -p "$DEST_DIR" || error_exit "Failed to create $DEST_DIR"

log "Starting backup: $SRC_DIR -> $BACKUP_FILE"

tar -czf "$BACKUP_FILE" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")" 2>>"$LOG_FILE"
if [ $? -ne 0 ]; then
  error_exit "tar failed while backing up $SRC_DIR"
fi

log "Backup created: $BACKUP_FILE"

BACKUP_COUNT=$(ls -1 "$DEST_DIR"/backup_*.tar.gz 2>/dev/null | wc -l)
if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
  ls -1t "$DEST_DIR"/backup_*.tar.gz | tail -n +"$((MAX_BACKUPS+1))" | xargs -r rm -f
  log "Rotated backups to keep last $MAX_BACKUPS files"
fi

exit 0
