#!/bin/bash
# Pre-Install Check Template: Port Availability
#
# This script checks if required ports are available for web applications.
# Uncomment and modify the sections below to use in your project.

# echo "Checking port availability..."

# Example: Define required ports
# REQUIRED_PORTS=(8080 5000 3000)

# Example: Check if a single port is available
# PORT=8080
# if netstat -tuln 2>/dev/null | grep -q ":$PORT "; then
#     echo "Error: Port $PORT is already in use"
#     echo ""
#     echo "Find process using port:"
#     echo "  sudo lsof -i :$PORT"
#     echo "  sudo netstat -tulpn | grep :$PORT"
#     exit 1
# fi
# echo "✓ Port $PORT is available"

# Example: Check multiple ports
# for PORT in "${REQUIRED_PORTS[@]}"; do
#     if netstat -tuln 2>/dev/null | grep -q ":$PORT " || ss -tuln 2>/dev/null | grep -q ":$PORT "; then
#         echo "Error: Port $PORT is already in use"
#         echo ""
#         echo "Process using port $PORT:"
#         if command -v lsof >/dev/null 2>&1; then
#             sudo lsof -i :$PORT
#         else
#             sudo netstat -tulpn | grep :$PORT
#         fi
#         echo ""
#         echo "To free the port, kill the process or choose a different port"
#         exit 1
#     fi
#     echo "✓ Port $PORT is available"
# done

# Example: Suggest alternative ports if occupied
# PORT=8080
# ALTERNATIVES=(8081 8082 8083 8084 8085)
# if netstat -tuln 2>/dev/null | grep -q ":$PORT " || ss -tuln 2>/dev/null | grep -q ":$PORT "; then
#     echo "Warning: Port $PORT is in use"
#     echo ""
#     echo "Alternative available ports:"
#     for ALT_PORT in "${ALTERNATIVES[@]}"; do
#         if ! netstat -tuln 2>/dev/null | grep -q ":$ALT_PORT " && ! ss -tuln 2>/dev/null | grep -q ":$ALT_PORT "; then
#             echo "  - $ALT_PORT (available)"
#         fi
#     done
#     echo ""
#     read -p "Continue anyway? [y/N]: " CONTINUE
#     if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
#         exit 1
#     fi
# fi

# Example: Check if firewall might block the port
# PORT=8080
# if command -v ufw >/dev/null 2>&1; then
#     UFW_STATUS=$(sudo ufw status 2>/dev/null)
#     if echo "$UFW_STATUS" | grep -q "Status: active"; then
#         if ! echo "$UFW_STATUS" | grep -q "$PORT"; then
#             echo "Warning: Firewall (ufw) is active and port $PORT may not be allowed"
#             echo ""
#             echo "Allow port through firewall:"
#             echo "  sudo ufw allow $PORT/tcp"
#         fi
#     fi
# fi

echo "Port availability check completed successfully!"
exit 0
