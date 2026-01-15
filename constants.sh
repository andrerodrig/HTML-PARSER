#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

BIN_NAME="htmlparser"
SOURCE_FILE="htmlparser.sh"

INSTALL_DIR="/usr/local/bin"
TARGET_PATH="$INSTALL_DIR/$BIN_NAME"

MSG_RUN_AS_ROOT="${RED}Please run as root (use sudo).${RESET}"
MSG_NOT_INSTALLED="$BIN_NAME is not installed."
MSG_INSTALLED="${GREEN}Installed successfully!${RESET}"
MSG_INSTALLATION_FAILED="${RED}Installation failed!${RESET}"
MSG_UNINSTALLED="${GREEN}Uninstalled successfully!${RESET}"
MSG_UNINSTALL_FAILED="${RED}Uninstall failed!${RESET}"
