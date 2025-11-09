#!/bin/bash
# log_monitor.sh - scans log files for errors/warnings and records alerts
source utils.sh || { echo "utils.sh not found"; exit 1; }

LOG_FILE_TO_SCAN="${1:-/var/log/syslog}"
KEYWORDS="${2:-error,fail,warning}"

IFS=',' read -ra WORDS <<< "$KEYWORDS"

log "Scanning $LOG_FILE_TO_SCAN for keywords: $KEYWORDS"

TMP_RESULT=$(mktemp)
for word in "${WORDS[@]}"; do
  grep -i "$word" "$LOG_FILE_TO_SCAN" >> "$TMP_RESULT"
done

if [ -s "$TMP_RESULT" ]; then
  {
    echo "---- $(date '+%Y-%m-%d %H:%M:%S') ----"
    cat "$TMP_RESULT"
    echo
  } >> "$ALERT_LOG"
  log "Issues detected in logs. Saved to $ALERT_LOG"
else
  log "No issues found in logs."
fi

rm -f "$TMP_RESULT"
