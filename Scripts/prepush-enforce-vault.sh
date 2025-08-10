#!/usr/bin/env bash
set -euo pipefail

LIST=".vault-tracked-files.txt"

if [[ -f "$LIST" ]]; then
  while IFS= read -r file; do
    # skip comments and empties
    [[ -z "$file" || "$file" =~ ^# ]] && continue

    if ! git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
      echo "Tracked vault file missing: $file" >&2
      exit 1
    fi
    if ! head -n 1 "$file" | grep -q '^\$ANSIBLE_VAULT;'; then
      echo "Tracked vault file is not encrypted: $file" >&2
      exit 1
    fi
  done < "$LIST"
fi

