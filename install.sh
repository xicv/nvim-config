#!/usr/bin/env bash
# install.sh — bootstrap this Neovim config on a fresh machine.
#
# Usage (one-liner):
#   curl -fsSL https://raw.githubusercontent.com/xicv/nvim-config/main/install.sh | bash
#
# Or, if you already cloned the repo:
#   git clone https://github.com/xicv/nvim-config.git ~/.config/nvim
#   bash ~/.config/nvim/install.sh
#
# What it does (idempotent):
#   1. Detects macOS (brew) or Linux (apt / pacman / dnf).
#   2. Installs system deps: neovim git ripgrep fd fzf node.
#   3. Backs up any existing ~/.config/nvim that isn't this repo.
#   4. Clones the repo to ~/.config/nvim if not already there.
#   5. Headless-runs :Lazy sync to install all Neovim plugins.
#   6. Headless-runs Mason to install LSP servers + formatters.
#   7. Builds Treesitter parsers.

set -euo pipefail

REPO_URL="https://github.com/xicv/nvim-config.git"
NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
DEPS=(neovim git ripgrep fd fzf node)
LOG()   { printf '\033[1;34m[install]\033[0m %s\n' "$*"; }
ERR()   { printf '\033[1;31m[error]\033[0m %s\n' "$*" >&2; exit 1; }

# ── 1. Detect package manager ──────────────────────────────────────────────
detect_pm() {
  case "$(uname -s)" in
    Darwin)
      command -v brew >/dev/null || ERR "Homebrew not installed. Get it from https://brew.sh"
      PM="brew" ;;
    Linux)
      if   command -v apt-get >/dev/null; then PM="apt"
      elif command -v pacman  >/dev/null; then PM="pacman"
      elif command -v dnf     >/dev/null; then PM="dnf"
      else ERR "No supported package manager (apt/pacman/dnf) found"
      fi ;;
    *) ERR "Unsupported OS: $(uname -s)" ;;
  esac
  LOG "Package manager: $PM"
}

# Translate generic name → package name for the current PM
pkg_name() {
  local g="$1"
  case "$PM:$g" in
    brew:fd)         echo "fd" ;;
    brew:node)       echo "node" ;;
    apt:fd)          echo "fd-find" ;;
    apt:node)        echo "nodejs" ;;
    apt:ripgrep)     echo "ripgrep" ;;
    apt:neovim)      echo "neovim" ;;
    pacman:fd)       echo "fd" ;;
    pacman:node)     echo "nodejs" ;;
    pacman:ripgrep)  echo "ripgrep" ;;
    pacman:neovim)   echo "neovim" ;;
    dnf:fd)          echo "fd-find" ;;
    dnf:node)        echo "nodejs" ;;
    dnf:ripgrep)     echo "ripgrep" ;;
    dnf:neovim)      echo "neovim" ;;
    *)               echo "$g" ;;
  esac
}

install_pkgs() {
  local pkgs=()
  for d in "${DEPS[@]}"; do pkgs+=("$(pkg_name "$d")"); done
  LOG "Installing system deps: ${pkgs[*]}"
  case "$PM" in
    brew)   brew install "${pkgs[@]}" || true ;;
    apt)    sudo apt-get update && sudo apt-get install -y "${pkgs[@]}" ;;
    pacman) sudo pacman -S --noconfirm --needed "${pkgs[@]}" ;;
    dnf)    sudo dnf install -y "${pkgs[@]}" ;;
  esac
}

# ── 2. Backup any pre-existing nvim config that isn't this repo ────────────
backup_existing() {
  if [[ -d "$NVIM_DIR" && ! -d "$NVIM_DIR/.git" ]]; then
    local bak="$NVIM_DIR.backup.$(date +%Y%m%d-%H%M%S)"
    LOG "Backing up existing $NVIM_DIR → $bak"
    mv "$NVIM_DIR" "$bak"
  fi
}

# ── 3. Clone repo if missing ───────────────────────────────────────────────
clone_repo() {
  if [[ ! -d "$NVIM_DIR/.git" ]]; then
    LOG "Cloning $REPO_URL → $NVIM_DIR"
    git clone --depth=1 "$REPO_URL" "$NVIM_DIR"
  else
    LOG "Repo already present at $NVIM_DIR (skipping clone)"
  fi
}

# ── 4. Headless plugin install ─────────────────────────────────────────────
run_lazy_sync() {
  LOG "Installing Lazy plugins (headless)…"
  nvim --headless "+Lazy! sync" +qa
}

run_mason_install() {
  LOG "Installing Mason LSP/formatter tools (headless)…"
  # mason-tool-installer.nvim auto-runs on start; give it time.
  nvim --headless -c 'lua vim.defer_fn(function() vim.cmd("MasonToolsInstallSync") end, 500)' -c 'qa' || true
}

run_treesitter() {
  LOG "Building Treesitter parsers (headless)…"
  nvim --headless "+TSUpdateSync" +qa || true
}

# ── main ───────────────────────────────────────────────────────────────────
main() {
  detect_pm
  install_pkgs
  backup_existing
  clone_repo
  run_lazy_sync
  run_mason_install
  run_treesitter
  LOG "Done. Launch with:  nvim"
  LOG "Press ,h inside nvim for the fuzzy keymap reference."
}

main "$@"
