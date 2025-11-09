# 🧰 System Maintenance Suite (Capstone Project)

Automated Linux system maintenance using **Bash scripting**.

---

## 🚀 Features
- 📦 File & directory backup with version rotation  
- 🔄 System update and cleanup  
- 🧠 Log monitoring for errors and warnings  
- 🧩 Unified interactive menu for easy control  
- ⏰ Cron automation ready  

---

## 📂 Folder Structure
| File | Description |
|------|--------------|
| **backup.sh** | Compresses directories into `.tar.gz` archives |
| **update_cleanup.sh** | Updates and cleans the system packages |
| **log_monitor.sh** | Scans system logs for errors, warnings, and failures |
| **utils.sh** | Helper functions for logging and notifications |
| **maintenance_suite.sh** | The main menu-driven script that integrates all functions |

---

## 🖥️ Usage

> 💡 Run the following commands inside **Ubuntu (WSL)** or any **Linux terminal**.

```bash
chmod +x *.sh
./maintenance_suite.sh

