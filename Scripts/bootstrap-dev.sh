#!/usr/bin/env bash
set -euo pipefail

# Bootstrap developer dependencies for hooks and tooling.
# Detect OS and install: pre-commit, gitleaks, ansible (ansible-vault)

case "$(uname -s)" in
  Darwin)
    command -v brew >/dev/null 2>&1 || { echo "Homebrew not found. Install from https://brew.sh" >&2; exit 1; }
    brew install pre-commit gitleaks ansible
    ;;
  Linux)
    if [[ -f /etc/debian_version ]]; then
      sudo apt-get update && sudo apt-get install -y pre-commit gitleaks ansible
    elif [[ -f /etc/redhat-release ]]; then
      sudo dnf install -y pre-commit gitleaks ansible
    elif [[ -f /etc/arch-release ]]; then
      sudo pacman -S --needed pre-commit gitleaks ansible
    else
      echo "Please install: pre-commit, gitleaks, ansible using your distribution's package manager." >&2
      exit 1
    fi
    ;;
  MINGW*|MSYS*|CYGWIN*)
    if command -v choco >/dev/null 2>&1; then
      choco install pre-commit gitleaks ansible
    elif command -v scoop >/dev/null 2>&1; then
      scoop install pre-commit gitleaks ansible
    else
      echo "Install Chocolatey (https://chocolatey.org) or Scoop and then install: pre-commit gitleaks ansible" >&2
      exit 1
    fi
    ;;
  *)
    echo "Unsupported OS. Install: pre-commit, gitleaks, ansible manually." >&2
    exit 1
    ;;
fi

# Install git hooks
pre-commit install
pre-commit install --hook-type pre-push

echo "Bootstrap complete."
