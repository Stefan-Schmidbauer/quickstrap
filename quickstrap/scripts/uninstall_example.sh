#!/bin/bash
# Uninstall Setup Template
#
# This script runs during './install.py --uninstall'. Its job is to undo the
# out-of-tree side effects that your matching post-install script created
# (desktop entries, databases, config directories, etc.).
#
# quickstrap removes the project-owned parts (venv, generated files) on its own.
# You only handle what your post-install script wrote OUTSIDE the project.
#
# Available Quickstrap variables (same environment as the post-install script):
#   $QUICKSTRAP_APP_NAME    - Application name from installation_profiles.ini
#   $QUICKSTRAP_CONFIG_DIR  - Project/config directory
#   $VIRTUAL_ENV            - Path to virtual environment (still present here)
#   $QUICKSTRAP_STATE_FILE  - Shared state file for this installation (see below)
#
# IMPORTANT - output & interactive prompts:
#   quickstrap CAPTURES this script's stdout/stderr (shown only after it exits)
#   and does not connect stdin. Plain echo therefore appears delayed, and an
#   interactive prompt (e.g. a sudo password) hangs silently with no visible
#   prompt. Undoing privileged side effects usually needs sudo - so talk to the
#   user through the controlling terminal /dev/tty, and on a no-tty install just
#   print the commands for them to run manually:
#
#     if { true >/dev/tty; } 2>/dev/null; then TTY=/dev/tty; else TTY=""; fi
#     say() { if [ -n "$TTY" ]; then printf '%s\n' "$*" >"$TTY"; else printf '%s\n' "$*"; fi; }
#     if [ -n "$TTY" ]; then
#         sudo rm -f /etc/foo <"$TTY" >"$TTY" 2>&1   # prompt stays visible/readable
#     else
#         say "No terminal - run manually:  sudo rm -f /etc/foo"
#     fi
#
# Two ways to know WHAT to remove:
#
# 1) Deterministic paths - recompute them from the environment, exactly like the
#    install script did. No recorded state needed. Example:
#
#    APP_NAME="${QUICKSTRAP_APP_NAME:-My Application}"
#    DESKTOP_FILE="$HOME/.local/share/applications/$(echo "$APP_NAME" \
#        | tr '[:upper:]' '[:lower:]' | tr ' ' '-').desktop"
#    rm -f "$DESKTOP_FILE"
#
# 2) Runtime state - things the install script could NOT predict (a chosen free
#    port, a generated path, a random DB name). The install script records these
#    in $QUICKSTRAP_STATE_FILE (a single file shared by all of this installation's
#    scripts, so the install and uninstall side resolve to the same path); this
#    script reads them back.
#
#    STATE FILE CONVENTION (recommended, not enforced):
#      - UTF-8 text, one entry per line
#      - '#' comments and blank lines are ignored
#      - by default each line is an absolute path to remove
#    Your post-install script registers a path with:
#      echo "$some_path" >> "$QUICKSTRAP_STATE_FILE"
#    And this uninstall script removes them:
#
#    if [ -n "$QUICKSTRAP_STATE_FILE" ] && [ -f "$QUICKSTRAP_STATE_FILE" ]; then
#        while IFS= read -r line; do
#            # skip comments and blank lines
#            case "$line" in ''|\#*) continue ;; esac
#            echo "Removing $line"
#            rm -rf "$line"
#        done < "$QUICKSTRAP_STATE_FILE"
#    fi
#
#    For richer state your script may use its own key=value format - quickstrap
#    never reads this file, so the format is entirely up to you.

echo "WARNING: This is a template script. Uncomment and customize the steps above before use."
exit 0
