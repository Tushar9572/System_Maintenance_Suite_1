#!/bin/bash
# utils.sh - common utilities for maintenance scripts

LOG_FILE="$HOME/system_maintenance.log"
ALERT_LOG="$HOME/log_alerts.txt"

# Ensure log files exist
touch "$LOG_FILE"
touch "$ALERT_LOG"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

error_exit() {
  log "ERROR: $1"
  exit 1
}

send_email() {
  local subject="$1"
  local body="$2"
  if command -v mail >/dev/null 2>&1; then
    echo -e "$body" | mail -s "$subject" "$MAIL_TO" 2>/dev/null \
      && log "Email sent to $MAIL_TO with subject: $subject" \
      || log "Failed to send email (mail command returned non-zero)."
  else
    log "mail command not found; skipping email. (Install mailutils or configure an MTA)"
  fi
}
