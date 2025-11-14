#!/bin/bash

##############################################
# System Monitoring Script
# Author: DevOps Monitoring Script
# Version: 1.0
##############################################

# -------- Thresholds --------
DISK_THRESHOLD=80
MEM_THRESHOLD=80
CPU_THRESHOLD=3     # load average

# -------- Paths --------
LOG_FILE="/var/log/sys_monitor.log"
ALERT_EMAIL="admin@example.com"
SLACK_WEBHOOK=""

# -------- Function: Send Alert --------
send_alert() {
    MESSAGE="$1"
    
    echo "$(date): ALERT - $MESSAGE" | tee -a $LOG_FILE
    
    # EMAIL ALERT
    echo "$MESSAGE" | mail -s "SYSTEM ALERT: $(hostname)" $ALERT_EMAIL

    # SLACK ALERT (Optional)
    if [[ ! -z "$SLACK_WEBHOOK" ]]; then
        curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"$MESSAGE\"}" $SLACK_WEBHOOK
    fi
}

# -------- Disk Check --------
check_disk() {
    echo "Checking Disk Usage..." >> $LOG_FILE

    df -hP | awk 'NR>1 {print $5 " " $6}' | while read output; do
        USAGE=$(echo $output | awk '{print $1}' | sed 's/%//')
        PARTITION=$(echo $output | awk '{print $2}')

        if [ $USAGE -ge $DISK_THRESHOLD ]; then
            send_alert "Disk usage critical: $PARTITION is ${USAGE}% full!"
        fi
    done
}

# -------- Memory Check --------
check_memory() {
    MEM_USED=$(free | grep Mem | awk '{print ($3/$2)*100}' | cut -d. -f1)

    if [ $MEM_USED -ge $MEM_THRESHOLD ]; then
        send_alert "Memory usage high: ${MEM_USED}% used!"
    fi
}

# -------- CPU Check --------
check_cpu() {
    LOAD=$(cut -d " " -f1 < /proc/loadavg | cut -d. -f1)

    if [ $LOAD -ge $CPU_THRESHOLD ]; then
        send_alert "CPU load high: Load average = $LOAD"
    fi
}

# -------- Log Cleanup --------
clean_logs() {
    LOG_DIR="/var/log"
    echo "Cleaning logs older than 15 days..." >> $LOG_FILE
    find $LOG_DIR -type f -name "*.log" -mtime +15 -exec rm -f {} \;
}

# -------- Main Execution --------
echo "--------------------------------------------------" >> $LOG_FILE
echo "RUNNING MONITOR - $(date)" >> $LOG_FILE
echo "--------------------------------------------------" >> $LOG_FILE

check_disk
check_memory
check_cpu
clean_logs

echo "Script completed successfully." >> $LOG_FILE
