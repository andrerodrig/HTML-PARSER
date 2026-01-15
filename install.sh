#!/usr/bin/env bash

set -e

source "./constants.sh"

# Check if running as root
if [[ "$UID" -ne 0 ]]; then
  echo -e "$MSG_RUN_AS_ROOT"
  exit 1
fi

# Check source file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
  echo "$SOURCE_FILE not found in current directory."
  exit 1
fi

echo "Installing $BIN_NAME..."

# Copy file
cp "$SOURCE_FILE" "$TARGET_PATH"

# Make executable
chmod +x "$TARGET_PATH"

# Verify installation
if command -v "$BIN_NAME" >/dev/null 2>&1; then
  echo -e "$MSG_INSTALLED"
  echo "Run with: $BIN_NAME"
else
  echo -e "$MSG_INSTALLATION_FAILED"
  exit 1
fi
