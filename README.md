# SEASnet Login Utility

A secure, cross-platform command-line utility for connecting to SEASnet servers on macOS and Linux. This tool stores your credentials securely using platform-native keychain services and provides an interactive menu for easy access.

## Features

- **Secure Credential Storage**: Uses macOS Keychain or GNOME Keyring for secure password storage
- **Cross-Platform Support**: Works on both macOS and Linux
- **Interactive Menu**: Simple, user-friendly interface
- **Quick Setup**: One-time credential configuration
- **Easy Updates**: Update credentials anytime
- **Terminal Integration**: Works seamlessly from any terminal

## Supported Platforms

- **macOS**: Uses Keychain for secure credential storage
- **Linux**: Uses GNOME Keyring (secret-tool) for secure credential storage

## Requirements

### macOS
- macOS (uses macOS Keychain for secure storage)
- `sshpass` (for automated SSH authentication)
- SEASnet account credentials

### Linux
- Linux with GNOME Keyring support
- `sshpass` (for automated SSH authentication)
- `secret-tool` (GNOME Keyring command-line interface)
- SEASnet account credentials

## Installation

### Quick Install

1. Clone this repository:
   ```bash
   git clone https://github.com/OwenBattles/seaslogin.git
   cd seaslogin
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

The installer will:
- Detect your platform (macOS or Linux)
- Check for required dependencies
- Copy `seaslogin` to the appropriate directory
- Make it available system-wide

### Manual Installation

If you prefer to install manually:

1. Make the script executable:
   ```bash
   chmod +x seaslogin
   ```

2. Copy to your PATH:
   ```bash
   # macOS
   sudo cp seaslogin /usr/local/bin/
   
   # Linux (system-wide)
   sudo cp seaslogin /usr/local/bin/
   
   # Linux (user-only)
   mkdir -p ~/.local/bin
   cp seaslogin ~/.local/bin/
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

## Dependencies

### sshpass

The utility requires `sshpass` for automated SSH authentication. Install it using one of these methods:

**macOS (Homebrew):**
```bash
brew install hudochenkov/sshpass/sshpass
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install sshpass

# RHEL/CentOS
sudo yum install sshpass

# Fedora
sudo dnf install sshpass

# Arch Linux
sudo pacman -S sshpass
```

### Platform-Specific Dependencies

**macOS:**
- `security` command (included with macOS)

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install libsecret-tools

# RHEL/CentOS
sudo yum install libsecret-tools

# Fedora
sudo dnf install libsecret-tools

# Arch Linux
sudo pacman -S libsecret
```

## Usage

### First Time Setup

1. Run the utility:
   ```bash
   seaslogin
   ```

2. Choose option `1` to set your credentials
3. Enter your SEASnet email/username
4. Enter your password (input will be hidden)
5. Your credentials are now securely stored

### Daily Usage

Simply run:
```bash
seaslogin
```

Then choose option `2` to login to SEASnet.

### Menu Options

- **1) Set/Update Credentials**: Store or update your SEASnet credentials
- **2) Login to SEASnet**: Connect using stored credentials
- **3) Exit**: Close the utility

## Security

### macOS
- Passwords are stored securely in macOS Keychain, not in plain text
- Email/username is stored in a config file in your home directory (`~/.seaslogin_config`)
- The Keychain service name is unique (`seasnet-login-script`) to avoid conflicts
- First-time access may prompt for Keychain permission (expected behavior)

### Linux
- Passwords are stored securely in GNOME Keyring, not in plain text
- Email/username is stored in a config file in your home directory (`~/.seaslogin_config`)
- The service name is unique (`seasnet-login-script`) to avoid conflicts
- Requires a running keyring service (GNOME, KDE, etc.)

## Configuration

The utility creates a config file at `~/.seaslogin_config` containing:
```bash
export SEAS_EMAIL='your-email@seas.ucla.edu'
```

## Troubleshooting

### "sshpass not found"
Install sshpass using one of the methods listed in the Dependencies section.

### "secret-tool not found" (Linux)
Install libsecret-tools using one of the methods listed in the Dependencies section.

### "Password not found in credential store"
Run option 1 to set your credentials again. The password may have been deleted or the credential item corrupted.

### Permission denied errors
Make sure the script is executable:
```bash
chmod +x seaslogin
```

### macOS Keychain permission dialog
The first time you use the utility, macOS may ask for permission to access the Keychain. Click "Allow" to proceed.

### Linux keyring issues
Make sure you have a keyring service running:
- GNOME: Should work automatically
- KDE: Install and configure kwallet
- Other desktop environments: May need to install and configure a keyring service

### PATH issues (Linux)
If `seaslogin` is not found after installation, add the installation directory to your PATH:
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Uninstallation

To remove the utility:

1. Remove the binary:
   ```bash
   # macOS
   sudo rm /usr/local/bin/seaslogin
   
   # Linux (system-wide)
   sudo rm /usr/local/bin/seaslogin
   
   # Linux (user-only)
   rm ~/.local/bin/seaslogin
   ```

2. Remove your stored credentials (optional):
   ```bash
   # macOS
   security delete-generic-password -s "seasnet-login-script"
   
   # Linux
   secret-tool clear --label="seasnet-login-script" service "seasnet-login-script"
   
   # Remove config file
   rm ~/.seaslogin_config
   ```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly on both macOS and Linux
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:

1. Check the [troubleshooting section](#troubleshooting)
2. Search existing [issues](https://github.com/OwenBattles/seaslogin/issues)
3. Create a new issue with detailed information including your platform and error messages

## Acknowledgments

- Built for the UCLA SEASnet community
- Uses platform-native keychain services for secure credential storage
- Inspired by the need for a simple, secure, cross-platform SSH login utility

---

**Note**: This utility is designed specifically for SEASnet servers at UCLA. Modify the SSH connection details in the script if adapting for other servers.