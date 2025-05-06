######################################################################
#     BASH Script to pull a report of all the inventory on OCI       #
#                 Authored by JAIUPADH on 06/05/2025                 #
#                         Version 1                                  #
######################################################################

#Prerequisites
#1. Access to OCI & Create a Linux virtual machine (VM) instance to deploy the script on.
#2. Install the OCI command line interface (CLI) on the VM or run the script from Cloud Shell.

#!/bin/bash

OUTPUT_FILE="oci_inventory_report_$(date +%Y%m%d_%H%M%S).csv"

# CSV Header
echo "CompartmentName,ResourceType,Name,AdditionalInfo" > "$OUTPUT_FILE"

# Load tenancy OCID
TENANCY_OCID=$(oci iam tenancy get --query "data.id" --raw-output)

# Get all compartments including root
echo "Fetching compartments..."
COMPARTMENTS=$(oci iam compartment list \
    --compartment-id "$TENANCY_OCID" \
    --access-level ANY \
    --compartment-id-in-subtree true \
    --query "data[].{Name:name, OCID:id}" \
    --raw-output)

# Add root compartment
ROOT_COMPARTMENT_NAME=$(oci iam tenancy get --query "data.name" --raw-output)
COMPARTMENTS="$COMPARTMENTS"$'\n'"$ROOT_COMPARTMENT_NAME $TENANCY_OCID"

# Get object storage namespace
NAMESPACE=$(oci os ns get --query 'data' --raw-output)

while read -r COMPARTMENT_NAME COMPARTMENT_ID; do
    echo "Processing: $COMPARTMENT_NAME"

    #Compute Instances Available
    oci compute instance list --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:display-name, State:life-cycle-state}" \
        --raw-output 2>/dev/null | while read -r NAME STATE; do
            echo "\"$COMPARTMENT_NAME\",\"ComputeInstance\",\"$NAME\",\"State=$STATE\"" >> "$OUTPUT_FILE"
        done

    #Block Volumes Available
    oci bv volume list --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:display-name, Size:size-in-gbs}" \
        --raw-output 2>/dev/null | while read -r NAME SIZE; do
            echo "\"$COMPARTMENT_NAME\",\"BlockVolume\",\"$NAME\",\"Size=${SIZE}GB\"" >> "$OUTPUT_FILE"
        done

    #VCNs
    oci network vcn list --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:display-name, CIDR:cidr-block}" \
        --raw-output 2>/dev/null | while read -r NAME CIDR; do
            echo "\"$COMPARTMENT_NAME\",\"VCN\",\"$NAME\",\"CIDR=$CIDR\"" >> "$OUTPUT_FILE"
        done

    #Object Storage Buckets
    oci os bucket list --namespace-name "$NAMESPACE" \
        --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:name}" \
        --raw-output 2>/dev/null | while read -r NAME; do
            echo "\"$COMPARTMENT_NAME\",\"Bucket\",\"$NAME\",\"\"" >> "$OUTPUT_FILE"
        done

    # File Storage Systems
    oci fs file-system list --compartment-id "$COMPARTMENT_ID" \
        --query "data[].{Name:display-name, OCID:id}" \
        --raw-output 2>/dev/null | while read -r NAME OCID; do
            echo "\"$COMPARTMENT_NAME\",\"FSS\",\"$NAME\",\"OCID=$OCID\"" >> "$OUTPUT_FILE"
        done

done <<< "$COMPARTMENTS"

echo "Inventory collection successfully completed."
echo "CSV output saved to: $OUTPUT_FILE"
