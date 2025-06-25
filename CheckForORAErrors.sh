######################################################################
#     BASH Script to check for ORA Errors from a given Log file      #
#                 Authored by JAIUPADH on 25/06/2025                 #
#                         Version 1.0                                #
######################################################################

#!/bin/sh

# Input file (source of Oracle logs)
INPUT_FILE="/home/jaiupadh/Desktop/OracleLog.txt"

# Output file (where ORA errors will be logged)
LOG_FILE="/home/jaiupadh/Desktop/ora_errors_extract.log"

# Create the log file if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
  echo "Creating log file: $LOG_FILE"
  echo "==== ORA Error Log Started on $(date '+%Y-%m-%d %H:%M:%S') ====" > "$LOG_FILE"
  echo "" >> "$LOG_FILE"
fi

# Get current timestamp
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Extract ORA errors from input file
ORA_ERRORS=$(grep "ORA-[0-9]\{5,\}" "$INPUT_FILE")

# If any ORA errors found, append them with timestamp
if [ -n "$ORA_ERRORS" ]; then
  {
    echo "===== ORA Errors Logged at $CURRENT_TIME ====="
    echo "$ORA_ERRORS"
    echo ""
  } >> "$LOG_FILE"

  echo -e "ORA errors appended to $LOG_FILE \n Exiting..."
else
  echo -e "No ORA errors found in $INPUT_FILE \n Exiting..."
fi
