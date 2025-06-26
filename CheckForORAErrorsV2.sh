######################################################################
#     BASH Script to check for ORA Errors from a given Log file      #
#                 Authored by JAIUPADH on 26/06/2025                 #
#                         Version 2.0                                #
######################################################################
#Pre-Requisites
# 1. "mail" or "mailx" should be installed
# 2. System must be configured to send emails via sendmail/postfix or SMTP.

#How to schedule Script with Cron:
# Step 1: Make the script executable : chmod +x CheckForORAErrors.sh
# Step 2: Edit crontab : crontab -e
# Step 3: Add cron entry (e.g., run daily at 7 AM) : 0 7 * * * /home/youruser/scripts/CheckForORAErrors.sh >> /home/youruser/scripts/ora_cron.log 2>&1

#!/bin/sh

#Input file (source of Oracle logs).
INPUT_FILE="/home/jaiupadh/Desktop/OracleLog.txt"

#Output file (where ORA errors will be logged).
LOG_FILE="/home/jaiupadh/Desktop/ora_errors_extract.log"

#Defining Email Address & Subject line.
EMAIL_TO="recipient@example.com"
EMAIL_SUBJECT="Attention! ORACLE Database Error Report - $(date '+%Y-%m-%d %H:%M:%S')"

# Create the log file if it doesn't exist.
if [ ! -f "$LOG_FILE" ]; then
  echo "Creating log file: $LOG_FILE"
  echo "==== ORACLE Database Error Log Started on $(date '+%Y-%m-%d %H:%M:%S') ====" > "$LOG_FILE"
  echo "" >> "$LOG_FILE"
fi

# Get current timestamp.
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Extract ORA errors from input file.
ORACLE_Database_ERRORS=$(grep "ORA-[0-9]\{5,\}" "$INPUT_FILE")

# If any ORA errors found, append them with timestamp.
if [ -n "$ORA_ERRORS" ]; then
  {
    echo "===== ORA Errors Logged at $CURRENT_TIME ====="
    echo "$ORA_ERRORS"
    echo ""
  } >> "$LOG_FILE"

  echo -e "ORA errors appended to $LOG_FILE \n Sending via Email & Exiting..."
# Send an email to the specified DL.
  echo "$ORACLE_Database_ERRORS" | mail -s "$EMAIL_SUBJECT" -a "$LOG_FILE" "$EMAIL_TO" < /dev/null
  echo -e "ORACLE_Database errors logged and emailed to $EMAIL_TO \n Exiting..."
else
  echo -e "Success - No ORACLE Database errors found in $INPUT_FILE \n Exiting..."
fi
