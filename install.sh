#!/bin/bash

# SEASnet Login Utility - Installation Script
# This script installs seaslogin to /usr/local/bin for system-wide access

set -e

echo "Installing SEASnet Login Utility..."

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This utility is designed for macOS only."
    echo "   The script uses macOS Keychain for secure password storage."
    exit 1
fi

# Check if sshpass is installed
if ! command -v sshpass &> /dev/null; then
    echo "Warning: sshpass is not installed."
    echo "   You can install it using Homebrew: brew install hudochenkov/sshpass/sshpass"
    echo "   Or using MacPorts: sudo port install sshpass"
    echo ""
    read -p "Continue installation anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SEASLOGIN_SCRIPT="$SCRIPT_DIR/seaslogin"

# Check if seaslogin script exists
if [[ ! -f "$SEASLOGIN_SCRIPT" ]]; then
    echo "Error: seaslogin script not found in $SCRIPT_DIR"
    exit 1
fi

# Make sure the script is executable
chmod +x "$SEASLOGIN_SCRIPT"

# Create /usr/local/bin if it doesn't exist
sudo mkdir -p /usr/local/bin

# Copy the script to /usr/local/bin
echo "Copying seaslogin to /usr/local/bin..."
sudo cp "$SEASLOGIN_SCRIPT" /usr/local/bin/

# Make sure it's executable in the new location
sudo chmod +x /usr/local/bin/seaslogin

echo "Installation complete!"
echo ""
echo "You can now use 'seaslogin' from anywhere in your terminal."
echo ""
echo "First time setup:"
echo "  1. Run 'seaslogin' to start the utility"
echo "  2. Choose option 1 to set your SEASnet credentials"
echo "  3. Your credentials will be securely stored in macOS Keychain"
echo ""
echo "Usage:"
echo "  seaslogin    # Start the interactive menu"
echo ""
echo "For help or to report issues, visit: https://github.com/OwenBattles/seaslogin"
