#!/bin/bash
# Post-Install Setup Template: Desktop Entry
#
# This script creates a .desktop file for desktop integration.
# Uncomment and modify the sections below to use in your project.
#
# Available Quickstrap variables:
#   $QUICKSTRAP_APP_NAME    - Application name from installation_profiles.ini
#   $QUICKSTRAP_CONFIG_DIR  - Config directory name
#   $VIRTUAL_ENV            - Path to virtual environment

# echo "Setting up desktop integration..."

# Example: Create desktop entry directory
# DESKTOP_DIR="$HOME/.local/share/applications"
# mkdir -p "$DESKTOP_DIR"

# Example: Define desktop entry details
# APP_NAME="${QUICKSTRAP_APP_NAME:-My Application}"
# DESKTOP_FILE="$DESKTOP_DIR/$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-').desktop"
# PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# START_SCRIPT="$PROJECT_ROOT/start.sh"

# Example: Create .desktop file
# cat > "$DESKTOP_FILE" << EOF
# [Desktop Entry]
# Version=1.0
# Type=Application
# Name=$APP_NAME
# Comment=Launch $APP_NAME
# Exec=$START_SCRIPT
# Icon=$PROJECT_ROOT/icon.png
# Terminal=false
# Categories=Utility;Application;
# EOF

# Example: With terminal output visible
# cat > "$DESKTOP_FILE" << EOF
# [Desktop Entry]
# Version=1.0
# Type=Application
# Name=$APP_NAME
# Comment=Launch $APP_NAME
# Exec=x-terminal-emulator -e $START_SCRIPT
# Icon=$PROJECT_ROOT/icon.png
# Terminal=true
# Categories=Utility;Application;
# EOF

# Example: Make executable if needed
# chmod +x "$DESKTOP_FILE"

# Example: Update desktop database
# if command -v update-desktop-database >/dev/null 2>&1; then
#     update-desktop-database "$DESKTOP_DIR"
#     echo "✓ Desktop database updated"
# fi

# Example: Show desktop entry location
# echo "✓ Desktop entry created: $DESKTOP_FILE"
# echo ""
# echo "Application should appear in your application menu"
# echo "You can also find it at: $DESKTOP_FILE"

# Example: Create desktop shortcut (on desktop itself)
# if [ -d "$HOME/Desktop" ]; then
#     DESKTOP_SHORTCUT="$HOME/Desktop/$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-').desktop"
#     cp "$DESKTOP_FILE" "$DESKTOP_SHORTCUT"
#     chmod +x "$DESKTOP_SHORTCUT"
#     echo "✓ Desktop shortcut created: $DESKTOP_SHORTCUT"
# fi

echo "Desktop integration setup completed successfully!"
exit 0
