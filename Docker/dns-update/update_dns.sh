#!/bin/bash

if [[ -z "$AZURE_APP_ID" || -z "$AZURE_TENANT_ID" || -z "$AZURE_SECRET" || -z "$RESOURCE_GROUP" || -z "$DNS_ZONE_NAME" || -z "$RECORD_SET_NAME" ]]; then
  echo "One or more required environment variables are missing. Exiting."
  exit 1
fi

while true; do
  # Get the current public IP
  CURRENT_IP=$(curl -s http://ifconfig.me)

  if [ -z "$CURRENT_IP" ]; then
    echo "Failed to retrieve public IP. Retrying in 10 minutes..."
    sleep 600
    continue
  fi

  # Authenticate with Azure CLI using the service principal
  az login --service-principal -u "$AZURE_APP_ID" -p "$AZURE_SECRET" --tenant "$AZURE_TENANT_ID"
  if [ $? -ne 0 ]; then
    echo "Azure CLI login failed. Retrying in 10 minutes..."
    sleep 600
    continue
  fi

  # Get the current DNS A record IP
  EXISTING_IP=$(az network dns record-set a show \
    --resource-group "$RESOURCE_GROUP" \
    --zone-name "$DNS_ZONE_NAME" \
    --name "$RECORD_SET_NAME" \
    --query "ARecords[0].ipv4Address" -o tsv)

  if [ "$CURRENT_IP" == "$EXISTING_IP" ]; then
    echo "IP address has not changed. No update needed."
  else
    # Update the A record in Azure DNS
    az network dns record-set a update \
      --resource-group "$RESOURCE_GROUP" \
      --zone-name "$DNS_ZONE_NAME" \
      --name "$RECORD_SET_NAME" \
      --set "aRecords[0].ipv4Address=$CURRENT_IP"

    if [ $? -ne 0 ]; then
      echo "Failed to update the A record. Retrying in 10 minutes..."
      sleep 600
      continue
    fi

    echo "DNS A record updated successfully with IP $CURRENT_IP."
  fi

  # Sleep for 10 minutes before repeating
  sleep 600
done