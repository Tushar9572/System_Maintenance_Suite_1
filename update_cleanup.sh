#!/bin/bash
# update_cleanup.sh - updates and cleans system packages
source utils.sh || { echo "utils.sh not found"; exit 1; }

log "Starting system update & cleanup"

if [ -f /etc/debian_version ]; then
  sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
  log "System update & cleanup finished (Debian/Ubuntu)"
elif [ -f /etc/redhat-release ]; then
  sudo dnf update -y && sudo dnf autoremove -y
  log "System update & cleanup finished (RHEL/Fedora)"
else
  log "Unknown Linux distribution; skipping package update."
fi

exit 0
