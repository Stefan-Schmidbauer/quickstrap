#!/bin/bash
#
# Quickstrap Developer Mode Activation
#
# Source this file in your shell to activate the virtual environment
# for development sessions:
#
#   source quickstrap/activate.sh
#
# This provides:
# - Activated virtual environment
# - Quickstrap environment variables (QUICKSTRAP_APP_NAME, QUICKSTRAP_CONFIG_DIR)
# - Updated PATH with venv binaries
#

# Determine script directory (works even when sourced)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

# Check if venv exists
VENV_PATH="$PROJECT_ROOT/venv"
if [ ! -d "$VENV_PATH" ]; then
    echo "Error: Virtual environment not found at $VENV_PATH"
    echo "Please run ./install.py first to create the virtual environment"
    return 1 2>/dev/null || exit 1
fi

# Activate virtual environment
source "$VENV_PATH/bin/activate"

# Load Quickstrap metadata from installation_profiles.ini
CONFIG_FILE="$PROJECT_ROOT/quickstrap/installation_profiles.ini"
if [ -f "$CONFIG_FILE" ]; then
    # Parse INI file for metadata
    export QUICKSTRAP_APP_NAME=$(grep -A 10 '^\[metadata\]' "$CONFIG_FILE" | grep '^app_name' | cut -d'=' -f2- | xargs)
    export QUICKSTRAP_CONFIG_DIR=$(grep -A 10 '^\[metadata\]' "$CONFIG_FILE" | grep '^config_dir' | cut -d'=' -f2- | xargs)
fi

# Set developer mode flag
export QUICKSTRAP_DEV=1

# Show activation message
echo "╭───────────────────────────────────────────────╮"
echo "│  Quickstrap Developer Mode Activated         │"
echo "╰───────────────────────────────────────────────╯"
echo ""
echo "Environment:"
echo "  • Virtual environment: $VENV_PATH"
[ -n "$QUICKSTRAP_APP_NAME" ] && echo "  • App name: $QUICKSTRAP_APP_NAME"
[ -n "$QUICKSTRAP_CONFIG_DIR" ] && echo "  • Config dir: ~/.config/$QUICKSTRAP_CONFIG_DIR"
echo ""
echo "Python: $(python --version)"
echo ""
echo "To deactivate, run: deactivate"
