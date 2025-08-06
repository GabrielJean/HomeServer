#!/bin/bash

# Script to make kubeconfig permanent
# This script will copy the new kubeconfig to the default kubectl location

set -e

KUBECONFIG_SOURCE="/home/gabriel/HomeServer/K8s/kubeconfigs/rke2-k8s-master-1.yaml"
KUBECONFIG_DEST="$HOME/.kube/config"

echo "Making kubeconfig permanent..."

# Create .kube directory if it doesn't exist
mkdir -p "$HOME/.kube"

# Check if source file exists
if [[ ! -f "$KUBECONFIG_SOURCE" ]]; then
    echo "Error: Source kubeconfig file not found at $KUBECONFIG_SOURCE"
    exit 1
fi

# Backup existing config if it exists
if [[ -f "$KUBECONFIG_DEST" ]]; then
    echo "Backing up existing kubeconfig to ${KUBECONFIG_DEST}.backup"
    cp "$KUBECONFIG_DEST" "${KUBECONFIG_DEST}.backup"
fi

# Copy new kubeconfig (force overwrite)
echo "Copying new kubeconfig to $KUBECONFIG_DEST"
cp "$KUBECONFIG_SOURCE" "$KUBECONFIG_DEST"

# Set proper permissions
chmod 600 "$KUBECONFIG_DEST"

echo "Testing connection..."
if kubectl cluster-info > /dev/null 2>&1; then
    echo "✅ Success! Kubeconfig is now permanent and working."
    echo "You can now use kubectl without specifying --kubeconfig"
else
    echo "❌ Error: Connection test failed. Restoring backup if available."
    if [[ -f "${KUBECONFIG_DEST}.backup" ]]; then
        cp "${KUBECONFIG_DEST}.backup" "$KUBECONFIG_DEST"
        echo "Backup restored."
    fi
    exit 1
fi

echo "Done!"
