######################################################################
#     BASH Script to pull a report of all the inventory on OCI       #
#                 Authored by JAIUPADH on 07/05/2025                 #
#                         Version 2                                  #
######################################################################

#Prerequisites
#1. Access to OCI & Create a Linux virtual machine (VM) instance to deploy the script on.
#2. Install the OCI command line interface (CLI) on the VM or run the script from Cloud Shell.

#!/bin/bash

#Set output directory (can be changed if needed)
OUTPUT_DIR="./oci_inventory_report"
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
CSV_FILE="$OUTPUT_DIR/oci_inventory_$TIMESTAMP.csv"
LOG_FILE="$OUTPUT_DIR/oci_inventory_$TIMESTAMP.log"

#CSV Header
echo "CompartmentName,ResourceType,Name,AdditionalInfo" > "$CSV_FILE"

#Logging helper
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

#Start logging
log "Starting OCI Inventory Collection..."
log "Output CSV: $CSV_FILE"

#Get tenancy ID
TENANCY_OCID=$(oci iam tenancy get --query "data.id" --raw-output 2>>"$LOG_FILE")
if [ -z "$TENANCY_OCID" ]; then
    log "ERROR: Failed to retrieve tenancy OCID."
    exit 1
fi

#Get all compartments including root
log "Fetching compartments..."
COMPARTMENTS=$(oci iam compartment list \
    --compartment-id "$TENANCY_OCID" \
    --access-level ANY \
    --compartment-id-in-subtree true \
    --query "data[].{Name:name, OCID:id}" \
    --raw-output 2>>"$LOG_FILE")

#Add root compartment
ROOT_NAME=$(oci iam tenancy get --query "data.name" --raw-output 2>>"$LOG_FILE")
COMPARTMENTS="$COMPARTMENTS"$'\n'"$ROOT_NAME $TENANCY_OCID"

#Get object storage namespace
NAMESPACE=$(oci os ns get --query 'data' --raw-output 2>>"$LOG_FILE")
if [ -z "$NAMESPACE" ]; then
    log "ERROR: Failed to get object storage namespace."
    exit 1
fi

while read -r COMPARTMENT_NAME COMPARTMENT_ID; do
    log "Processing compartment: $COMPARTMENT_NAME"

    #Compute Instances Report
    oci compute instance list --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:display-name, State:life-cycle-state}" \
        --raw-output 2>>"$LOG_FILE" | while read -r NAME STATE; do
            echo "\"$COMPARTMENT_NAME\",\"ComputeInstance\",\"$NAME\",\"State=$STATE\"" >> "$CSV_FILE"
        done

    #Block Volumes Report
    oci bv volume list --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:display-name, Size:size-in-gbs}" \
        --raw-output 2>>"$LOG_FILE" | while read -r NAME SIZE; do
            echo "\"$COMPARTMENT_NAME\",\"BlockVolume\",\"$NAME\",\"Size=${SIZE}GB\"" >> "$CSV_FILE"
        done

    #VCNs Report
    oci network vcn list --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:display-name, CIDR:cidr-block}" \
        --raw-output 2>>"$LOG_FILE" | while read -r NAME CIDR; do
            echo "\"$COMPARTMENT_NAME\",\"VCN\",\"$NAME\",\"CIDR=$CIDR\"" >> "$CSV_FILE"
        done

    #Object Storage Buckets Report
    oci os bucket list --namespace-name "$NAMESPACE" \
        --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:name}" \
        --raw-output 2>>"$LOG_FILE" | while read -r NAME; do
            echo "\"$COMPARTMENT_NAME\",\"Bucket\",\"$NAME\",\"\"" >> "$CSV_FILE"
        done

    #File Storage Systems (FSS) Report
    oci fs file-system list --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:display-name, OCID:id}" \
        --raw-output 2>>"$LOG_FILE" | while read -r NAME OCID; do
            echo "\"$COMPARTMENT_NAME\",\"FSS\",\"$NAME\",\"OCID=$OCID\"" >> "$CSV_FILE"
        done

done <<< "$COMPARTMENTS"

echo "Inventory collection successfully completed."
log "Inventory collection completed."
echo "CSV output saved to: $CSV_FILE"
log "CSV saved at: $CSV_FILE"
echo "Log saved at: $LOG_FILE"
log "Log saved at: $LOG_FILE"
