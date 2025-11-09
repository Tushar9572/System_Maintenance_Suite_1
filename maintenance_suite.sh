#!/bin/bash
# maintenance_suite.sh - interactive menu to run maintenance tasks
source utils.sh || { echo "utils.sh not found"; exit 1; }

while true; do
  clear
  echo "=========================================="
  echo "   🧰 System Maintenance Suite"
  echo "=========================================="
  echo "1) Run Backup"
  echo "2) Update & Cleanup System"
  echo "3) Monitor Logs"
  echo "4) Run All (Backup + Update + Monitor)"
  echo "5) Show Last 20 lines of main log"
  echo "6) Exit"
  echo "=========================================="
  read -rp "Choose an option [1-6]: " CHOICE

  case "$CHOICE" in
    1)
      read -rp "Source dir (default: $HOME/Documents): " S
      read -rp "Dest dir (default: $HOME/Backups): " D
      ./backup.sh "${S:-$HOME/Documents}" "${D:-$HOME/Backups}"
      ;;
    2)
      ./update_cleanup.sh
      ;;
    3)
      read -rp "Log file to scan (press Enter for default): " L
      read -rp "Keywords (comma-separated, default: error,fail,warning): " K
      ./log_monitor.sh "${L:-}" "${K:-}"
      ;;
    4)
      ./backup.sh
      ./update_cleanup.sh
      ./log_monitor.sh
      ;;
    5)
      tail -n 20 "$LOG_FILE" || echo "No log yet."
      read -rp "Press Enter to continue..."
      ;;
    6)
      echo "Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid option."
      ;;
  esac
  echo
  read -rp "Press Enter to return to menu..."
done
