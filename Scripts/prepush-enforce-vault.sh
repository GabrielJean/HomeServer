#!/usr/bin/env bash
set -euo pipefail

# Ensure required tools exist
need() { command -v "$1" >/dev/null 2>&1; }

missing=()
need gitleaks || missing+=(gitleaks)
need ansible-vault || missing+=(ansible/ansible-vault)

if (( ${#missing[@]} > 0 )); then
  echo "Missing required tools for pre-push checks: ${missing[*]}" >&2
  echo "Install instructions:" >&2
  case "$(uname -s)" in
    Darwin)
      echo "  brew install pre-commit gitleaks ansible" >&2 ;;
    Linux)
      # Provide generic guidance for common distros
      if [[ -f /etc/debian_version ]]; then
        echo "  sudo apt-get update && sudo apt-get install -y pre-commit gitleaks ansible" >&2
      elif [[ -f /etc/redhat-release ]]; then
        echo "  sudo dnf install -y pre-commit gitleaks ansible" >&2
      elif [[ -f /etc/arch-release ]]; then
        echo "  sudo pacman -S --needed pre-commit gitleaks ansible" >&2
      else
        echo "  Use your package manager to install: pre-commit, gitleaks, ansible" >&2
      fi
      ;;
    MINGW*|MSYS*|CYGWIN*)
      echo "  choco install pre-commit gitleaks ansible" >&2
      echo "  or: scoop install pre-commit gitleaks ansible" >&2 ;;
    *)
      echo "  Install pre-commit, gitleaks, and ansible (for ansible-vault) using your OS package manager." >&2 ;;
  esac
  echo "Alternatively, run scripts/bootstrap-dev.sh to set up dependencies." >&2
  exit 1
fi

LIST=".vault-tracked-files.txt"

if [[ -f "$LIST" ]]; then
  while IFS= read -r file; do
    # skip comments and empties
    [[ -z "$file" || "$file" =~ ^# ]] && continue

    if ! git ls-files --error-unmatch "$file" > /dev/null 2>&1; then
      echo "Tracked vault file missing: $file" >&2
      exit 1
    fi
    if ! head -n 1 "$file" | grep -q '^\$ANSIBLE_VAULT;'; then
      echo "Tracked vault file is not encrypted: $file" >&2
      exit 1
    fi
  done < "$LIST"
fi

