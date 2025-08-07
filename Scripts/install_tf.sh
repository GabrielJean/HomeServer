#!/usr/bin/env bash

set -e

echo "-----------------------------"
echo "   Terraform Install Script   "
echo "-----------------------------"
echo ""
echo "This script will:"
echo "  - Update your package list"
echo "  - Install required packages (gnupg, software-properties-common, wget)"
echo "  - Add and verify the HashiCorp GPG key"
echo "  - Add the Terraform apt repository"
echo "  - Install Terraform"
echo "  - Enable Terraform CLI autocompletion for bash and zsh"
echo ""

# (1) Update and install dependencies
echo "Step 1: Updating apt and installing dependencies..."
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common wget

# (2) Add HashiCorp's GPG key
echo "Step 2: Downloading and installing HashiCorp GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# (3) Verify GPG key fingerprint
echo "Step 3: Verifying the GPG key fingerprint..."
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

echo ""
echo "Please ensure the fingerprint above matches HashiCorp's official fingerprint, which can be verified at:"
echo "https://www.hashicorp.com/security"
read -n 1 -s -r -p "If the fingerprint looks correct, press any key to continue..."

echo ""

# (4) Add the HashiCorp Terraform official repository
echo "Step 4: Adding HashiCorp Terraform repository to APT sources..."
CODENAME=$(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs)
echo "Detected Ubuntu/Debian codename: $CODENAME"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $CODENAME main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# (5) Update APT again and install Terraform
echo "Step 5: Updating APT sources and installing Terraform..."
sudo apt-get update
sudo apt-get install -y terraform

# (6) Verify installation
echo "Step 6: Verifying Terraform installation..."
terraform -help || { echo "Terraform installation failed!"; exit 1; }

# (7) Enable autocompletion
echo "Step 7: Setting up Terraform CLI tab autocompletion..."

SHELL_NAME=$(basename "$SHELL")

if [[ "$SHELL_NAME" == "zsh" ]]; then
    touch ~/.zshrc
    terraform -install-autocomplete
    echo "Tab completion enabled for Zsh. Please restart your terminal or 'source ~/.zshrc'."
elif [[ "$SHELL_NAME" == "bash" ]]; then
    touch ~/.bashrc
    terraform -install-autocomplete
    echo "Tab completion enabled for Bash. Please restart your terminal or 'source ~/.bashrc'."
else
    echo "Unknown shell: $SHELL. Please run 'terraform -install-autocomplete' manually for your shell."
fi

echo ""
echo "Terraform has been installed!"
echo ""
echo "To learn more, run:"
echo "  terraform -help"
echo "  terraform plan -help"
echo ""
echo "You may need to restart your terminal session for autocompletion to work."
echo "Done!"