#!/usr/bin/env bash
set -euo pipefail

# Bootstrap developer dependencies for hooks and tooling.
# - pre-commit: via pipx on Linux (Ubuntu/WSL) for latest version
# - gitleaks: via apt if available, else download official release
# - ansible: via apt
# Then install pre-commit hooks (including pre-push).

log() { printf "[bootstrap] %s\n" "$*"; }
warn() { printf "[bootstrap][warn] %s\n" "$*" >&2; }
err() { printf "[bootstrap][error] %s\n" "$*" >&2; }

ensure_path_contains_local_bin() {
  # Ensure pipx-installed binaries are available in this shell
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
  fi
}

install_gitleaks_via_release() {
  local version="v8.18.4" # keep in sync with .pre-commit-config.yaml
  local arch
  case "$(uname -m)" in
    x86_64|amd64) arch="amd64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) err "Unsupported architecture $(uname -m) for gitleaks auto-install"; return 1 ;;
  esac
  local url="https://github.com/gitleaks/gitleaks/releases/download/${version}/gitleaks_${version#v}_linux_${arch}.tar.gz"
  local tmpdir
  tmpdir=$(mktemp -d)
  log "Downloading gitleaks ${version} from ${url}"
  curl -fsSL "$url" -o "$tmpdir/gitleaks.tgz"
  tar -xzf "$tmpdir/gitleaks.tgz" -C "$tmpdir"
  if [[ ! -f "$tmpdir/gitleaks" ]]; then
    err "gitleaks binary not found in archive"; return 1
  fi
  sudo install -m 0755 "$tmpdir/gitleaks" /usr/local/bin/gitleaks
  rm -rf "$tmpdir"
}

case "$(uname -s)" in
  Darwin)
    if ! command -v brew >/dev/null 2>&1; then
      err "Homebrew not found. Install from https://brew.sh"
      exit 1
    fi
    log "Installing dependencies via Homebrew"
    brew install pre-commit gitleaks ansible || true
    ;;
  Linux)
    if [[ -f /etc/debian_version ]]; then
      log "Detected Debian/Ubuntu. Updating APT cache"
      sudo apt-get update -y
      log "Installing base packages: git, curl, ansible, python3-pip, python3-venv, pipx"
      sudo apt-get install -y git curl ansible python3-pip python3-venv pipx
      # On some Ubuntu builds, ensurepip is disabled; attempt to bootstrap pip in stdlib venv
      python3 -m ensurepip --upgrade || true
      ensure_path_contains_local_bin
      # Ensure pipx is ready (this also prints shell integration message, which we handle via PATH export above)
      if command -v pipx >/dev/null 2>&1; then
        pipx ensurepath || true
      fi
      # Install/upgrade pre-commit via pipx for latest version
      if command -v pre-commit >/dev/null 2>&1; then
        log "pre-commit already installed: $(pre-commit --version)"
      else
        if command -v pipx >/dev/null 2>&1; then
          log "Installing pre-commit via pipx"
          pipx install --force pre-commit
        else
          warn "pipx not available, falling back to apt pre-commit"
          sudo apt-get install -y pre-commit || true
        fi
      fi
      # Install gitleaks (apt if available, else fallback to release)
      if command -v gitleaks >/dev/null 2>&1; then
        log "gitleaks already installed: $(gitleaks version 2>/dev/null || echo installed)"
      else
        log "Attempting to install gitleaks via apt"
        if sudo apt-get install -y gitleaks; then
          log "Installed gitleaks via apt"
        else
          warn "APT does not provide gitleaks or install failed; falling back to official release"
          install_gitleaks_via_release
        fi
      fi
    elif [[ -f /etc/redhat-release ]]; then
      log "Detected RHEL/Fedora. Installing via dnf"
      sudo dnf install -y git curl ansible python3-pip
      python3 -m pip install --user pipx
      ensure_path_contains_local_bin
      pipx ensurepath || true
      pipx install --force pre-commit
      command -v gitleaks >/dev/null 2>&1 || install_gitleaks_via_release
    elif [[ -f /etc/arch-release ]]; then
      log "Detected Arch. Installing via pacman"
      sudo pacman -S --needed --noconfirm git curl ansible python-pipx
      ensure_path_contains_local_bin
      pipx ensurepath || true
      pipx install --force pre-commit
      command -v gitleaks >/dev/null 2>&1 || sudo pacman -S --needed --noconfirm gitleaks || install_gitleaks_via_release
    else
      err "Unknown Linux distribution. Please install: pre-commit, gitleaks, ansible manually."
      exit 1
    fi
    ;;
  MINGW*|MSYS*|CYGWIN*)
    if command -v choco >/dev/null 2>&1; then
      log "Installing via Chocolatey"
      choco install -y pre-commit gitleaks ansible || true
    elif command -v scoop >/dev/null 2>&1; then
      log "Installing via Scoop"
      scoop install pre-commit gitleaks ansible || true
    else
      err "Install Chocolatey (https://chocolatey.org) or Scoop and then install: pre-commit gitleaks ansible"
      exit 1
    fi
    ;;
  *)
    err "Unsupported OS. Install: pre-commit, gitleaks, ansible manually."
    exit 1
    ;;
esac

ensure_path_contains_local_bin

# Install git hooks if pre-commit is available
if command -v pre-commit >/dev/null 2>&1; then
  log "Installing pre-commit hooks"
  pre-commit install || true
  pre-commit install --hook-type pre-push || true
else
  warn "pre-commit is not available on PATH; skipping hook installation"
fi

log "Bootstrap complete."
