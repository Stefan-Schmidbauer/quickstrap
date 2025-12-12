#!/bin/bash
# Pre-Install Check Template: NVIDIA Driver
#
# This script checks if NVIDIA drivers are available before installation.
# Uncomment and modify the sections below to use in your project.

# echo "Checking for NVIDIA GPU drivers..."

# Example: Check if nvidia-smi is available
# if ! command -v nvidia-smi >/dev/null 2>&1; then
#     echo "Error: NVIDIA driver not found (nvidia-smi not available)"
#     echo ""
#     echo "Install NVIDIA drivers:"
#     echo "  1. Check available versions: apt search nvidia-driver"
#     echo "  2. Install driver: sudo apt install nvidia-driver-XXX"
#     echo "  3. Reboot system"
#     exit 1
# fi
# echo "✓ NVIDIA driver found"

# Example: Show GPU information
# GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader | head -1)
# echo "  GPU: $GPU_NAME"

# Example: Check CUDA version
# CUDA_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader | head -1)
# echo "  Driver version: $CUDA_VERSION"

# Example: Check minimum driver version
# MIN_DRIVER_VERSION="470.0"
# DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader | head -1)
# if [ "$(printf '%s\n' "$MIN_DRIVER_VERSION" "$DRIVER_VERSION" | sort -V | head -n1)" != "$MIN_DRIVER_VERSION" ]; then
#     echo "Error: NVIDIA driver version $DRIVER_VERSION is too old"
#     echo "Minimum required version: $MIN_DRIVER_VERSION"
#     exit 1
# fi

echo "NVIDIA driver check completed successfully!"
exit 0
