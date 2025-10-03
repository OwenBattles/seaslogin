#!/bin/bash

# SEASnet Login Utility - Installation Script
# This script installs seaslogin to /usr/local/bin for system-wide access
# Supports both macOS and Linux platforms

set -e

echo "Installing SEASnet Login Utility..."

# --- Platform Detection ---
detect_platform() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "linux"
  else
    echo "unsupported"
  fi
}

PLATFORM=$(detect_platform)

# Check if platform is supported
if [[ "$PLATFORM" == "unsupported" ]]; then
    echo "Error: This utility supports macOS and Linux only."
    echo "   macOS uses Keychain for secure password storage."
    echo "   Linux uses GNOME Keyring (secret-tool) for secure password storage."
    exit 1
fi

echo "Detected platform: $PLATFORM"

# --- Dependency Checking ---
check_dependencies() {
    local missing_deps=()
    
    # Check for sshpass
    if ! command -v sshpass &> /dev/null; then
        missing_deps+=("sshpass")
    fi
    
    # Check platform-specific dependencies
    case "$PLATFORM" in
        "macos")
            if ! command -v security &> /dev/null; then
                missing_deps+=("security (macOS Keychain)")
            fi
            ;;
        "linux")
            if ! command -v secret-tool &> /dev/null; then
                missing_deps+=("secret-tool (GNOME Keyring)")
            fi
            ;;
    esac
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo "Warning: Missing dependencies:"
        for dep in "${missing_deps[@]}"; do
            echo "  - $dep"
        done
        echo ""
        echo "Installation instructions:"
        case "$PLATFORM" in
            "macos")
                echo "  sshpass: brew install hudochenkov/sshpass/sshpass"
                echo "  security: Already included with macOS"
                ;;
            "linux")
                echo "  sshpass:"
                echo "    Ubuntu/Debian: sudo apt-get install sshpass"
                echo "    RHEL/CentOS:   sudo yum install sshpass"
                echo "    Fedora:        sudo dnf install sshpass"
                echo "    Arch:          sudo pacman -S sshpass"
                echo ""
                echo "  secret-tool:"
                echo "    Ubuntu/Debian: sudo apt-get install libsecret-tools"
                echo "    RHEL/CentOS:   sudo yum install libsecret-tools"
                echo "    Fedora:        sudo dnf install libsecret-tools"
                echo "    Arch:          sudo pacman -S libsecret"
                ;;
        esac
        echo ""
        read -p "Continue installation anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Installation cancelled."
            exit 1
        fi
    fi
}

check_dependencies

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

# Determine installation directory based on platform
case "$PLATFORM" in
    "macos")
        INSTALL_DIR="/usr/local/bin"
        ;;
    "linux")
        # Check if /usr/local/bin exists and is writable, otherwise use ~/.local/bin
        if [[ -w "/usr/local/bin" ]]; then
            INSTALL_DIR="/usr/local/bin"
        else
            INSTALL_DIR="$HOME/.local/bin"
            mkdir -p "$INSTALL_DIR"
            echo "Note: Installing to $INSTALL_DIR (add to PATH if needed)"
        fi
        ;;
esac

# Create installation directory if it doesn't exist
sudo mkdir -p "$INSTALL_DIR"

# Copy the script to installation directory
echo "Copying seaslogin to $INSTALL_DIR..."
sudo cp "$SEASLOGIN_SCRIPT" "$INSTALL_DIR/"

# Make sure it's executable in the new location
sudo chmod +x "$INSTALL_DIR/seaslogin"

echo "Installation complete!"
echo ""
echo "You can now use 'seaslogin' from anywhere in your terminal."
echo ""

# Platform-specific notes
case "$PLATFORM" in
    "macos")
        echo "macOS Notes:"
        echo "  - Uses Keychain for secure credential storage"
        echo "  - First-time access may prompt for Keychain permission"
        ;;
    "linux")
        echo "Linux Notes:"
        echo "  - Uses GNOME Keyring for secure credential storage"
        echo "  - Make sure you have a keyring service running (GNOME, KDE, etc.)"
        if [[ "$INSTALL_DIR" == "$HOME/.local/bin" ]]; then
            echo "  - Add $INSTALL_DIR to your PATH if not already:"
            echo "    echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc"
            echo "    source ~/.bashrc"
        fi
        ;;
esac

echo ""
echo "First time setup:"
echo "  1. Run 'seaslogin' to start the utility"
echo "  2. Choose option 1 to set your SEASnet credentials"
echo "  3. Your credentials will be securely stored"
echo ""
echo "Usage:"
echo "  seaslogin    # Start the interactive menu"
echo ""
echo "For help or to report issues, visit: https://github.com/OwenBattles/seaslogin"