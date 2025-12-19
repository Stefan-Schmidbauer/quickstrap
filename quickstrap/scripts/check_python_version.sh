#!/bin/bash
# Pre-Install Check Template: Python Version
#
# This script checks if the Python version meets minimum requirements.
# Uncomment and modify the sections below to use in your project.

# echo "Checking Python version..."

# Example: Check minimum Python version
# MIN_PYTHON_VERSION="3.8"
# PYTHON_VERSION=$(python3 --version 2>&1 | grep -oP '\d+\.\d+' | head -1)
#
# if [ "$(printf '%s\n' "$MIN_PYTHON_VERSION" "$PYTHON_VERSION" | sort -V | head -n1)" != "$MIN_PYTHON_VERSION" ]; then
#     echo "Error: Python $PYTHON_VERSION is too old"
#     echo "Minimum required version: Python $MIN_PYTHON_VERSION"
#     echo ""
#     echo "Install newer Python version:"
#     echo "  sudo apt update"
#     echo "  sudo apt install python3.11 python3.11-venv"
#     exit 1
# fi
# echo "✓ Python $PYTHON_VERSION meets minimum requirement ($MIN_PYTHON_VERSION)"

# Example: Check for specific Python version
# REQUIRED_VERSION="3.11"
# PYTHON_VERSION=$(python3 --version 2>&1 | grep -oP '\d+\.\d+' | head -1)
#
# if [ "$PYTHON_VERSION" != "$REQUIRED_VERSION" ]; then
#     echo "Warning: Python $PYTHON_VERSION found, but $REQUIRED_VERSION is recommended"
#     echo ""
#     read -p "Continue anyway? [y/N]: " CONTINUE
#     if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
#         exit 1
#     fi
# fi

# Example: Check for python3-venv package
# if ! python3 -m venv --help >/dev/null 2>&1; then
#     echo "Error: python3-venv module not available"
#     echo ""
#     echo "Install venv module:"
#     PYTHON_VERSION=$(python3 --version 2>&1 | grep -oP '\d+\.\d+' | head -1)
#     echo "  sudo apt install python${PYTHON_VERSION}-venv"
#     exit 1
# fi
# echo "✓ python3-venv available"

# Example: Check for pip
# if ! python3 -m pip --version >/dev/null 2>&1; then
#     echo "Error: pip not available"
#     echo ""
#     echo "Install pip:"
#     echo "  sudo apt install python3-pip"
#     exit 1
# fi
# echo "✓ pip available"

# Example: Show full Python version
# FULL_VERSION=$(python3 --version)
# echo "  Python: $FULL_VERSION"

# Example: Check for development headers (needed for some packages)
# if ! dpkg -s python3-dev >/dev/null 2>&1; then
#     echo "Warning: python3-dev not installed"
#     echo "Some Python packages may fail to compile"
#     echo ""
#     echo "Install development headers:"
#     echo "  sudo apt install python3-dev"
# fi

echo "Python version check completed successfully!"
exit 0
