#!/bin/bash

# ==============================================================================
# Installation Script - Android to macOS Video Downloader
# ==============================================================================
# Creates a symbolic link in /usr/local/bin pointing to the downloader script
# so it can be run globally from anywhere on the system.
# ==============================================================================

# ANSI Color Codes
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
BOLD='\033[1m'

log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Resolve directory of this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
SRC_FILE="$SCRIPT_DIR/igrab"
DEST_LINK="/usr/local/bin/igrab"

# Check if source file exists
if [ ! -f "$SRC_FILE" ]; then
  log_error "Source file not found: $SRC_FILE"
  exit 1
fi

# Ensure source file is executable
chmod +x "$SRC_FILE"

# Ensure destination directory exists
if [ ! -d "/usr/local/bin" ]; then
  log_info "Creating directory /usr/local/bin..."
  if ! mkdir -p "/usr/local/bin" 2>/dev/null; then
    log_info "Requesting administrator (sudo) privileges to create /usr/local/bin..."
    if ! sudo mkdir -p "/usr/local/bin"; then
      log_error "Failed to create directory /usr/local/bin."
      exit 1
    fi
  fi
fi

# Create symlink
log_info "Creating symbolic link: $DEST_LINK -> $SRC_FILE"

# Check if destination directory is writable without sudo
success=false
if [ -w "/usr/local/bin" ]; then
  if ln -sf "$SRC_FILE" "$DEST_LINK"; then
    success=true
  fi
else
  log_info "Requesting administrator (sudo) privileges to write to /usr/local/bin..."
  if sudo ln -sf "$SRC_FILE" "$DEST_LINK"; then
    success=true
  fi
fi

if [ "$success" = true ] && [ -L "$DEST_LINK" ]; then
  log_success "Installation successful!"
  echo -e "You can now run the downloader from anywhere using: ${BOLD}igrab${NC}"
else
  log_error "Installation failed."
  exit 1
fi
