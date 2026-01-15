#!/usr/bin/env bash

set -e

source "./constants.sh"

# Check if running as root
if [[ "$UID" -ne 0 ]]; then
  echo -e "$MSG_RUN_AS_ROOT"
  exit 1
fi

# Check if installed
if [[ ! -f "$TARGET_PATH" ]]; then
  echo "$MSG_NOT_INSTALLED"
  exit 0
fi

echo "Uninstalling $BIN_NAME..."

rm -f "$TARGET_PATH"

# Verify removal
if command -v "$BIN_NAME" >/dev/null 2>&1; then
  echo -e "$MSG_UNINSTALL_FAILED"
  exit 1
else
  echo -e "$MSG_UNINSTALLED"
fi
