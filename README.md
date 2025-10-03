# SEASnet Login Utility

A secure, user-friendly command-line utility for connecting to SEASnet servers on macOS. This tool stores your credentials securely in the macOS Keychain and provides an interactive menu for easy access.

## Features

- 🔐 **Secure Credential Storage**: Uses macOS Keychain to store passwords securely
- 🎯 **Interactive Menu**: Simple, user-friendly interface
- 🚀 **Quick Setup**: One-time credential configuration
- 🔄 **Easy Updates**: Update credentials anytime
- 💻 **Terminal Integration**: Works seamlessly from any terminal

## Requirements

- macOS (uses macOS Keychain for secure storage)
- `sshpass` (for automated SSH authentication)
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
- Check for required dependencies
- Copy `seaslogin` to `/usr/local/bin`
- Make it available system-wide

### Manual Installation

If you prefer to install manually:

1. Make the script executable:
   ```bash
   chmod +x seaslogin
   ```

2. Copy to your PATH:
   ```bash
   sudo cp seaslogin /usr/local/bin/
   ```

## Dependencies

### sshpass

The utility requires `sshpass` for automated SSH authentication. Install it using one of these methods:

**Homebrew:**
```bash
brew install hudochenkov/sshpass/sshpass
```

**MacPorts:**
```bash
sudo port install sshpass
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
5. Your credentials are now securely stored in macOS Keychain

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

- Passwords are stored securely in macOS Keychain, not in plain text
- Email/username is stored in a config file in your home directory (`~/.seaslogin_config`)
- The Keychain service name is unique (`seasnet-login-script`) to avoid conflicts
- First-time access may prompt for Keychain permission (expected behavior)

## Configuration

The utility creates a config file at `~/.seaslogin_config` containing:
```bash
export SEAS_EMAIL='your-email@seas.ucla.edu'
```

## Troubleshooting

### "sshpass not found"
Install sshpass using one of the methods listed in the Dependencies section.

### "Password not found in Keychain"
Run option 1 to set your credentials again. The password may have been deleted or the Keychain item corrupted.

### Permission denied errors
Make sure the script is executable:
```bash
chmod +x seaslogin
```

### macOS Keychain permission dialog
The first time you use the utility, macOS may ask for permission to access the Keychain. Click "Allow" to proceed.

## Uninstallation

To remove the utility:

1. Remove the binary:
   ```bash
   sudo rm /usr/local/bin/seaslogin
   ```

2. Remove your stored credentials (optional):
   ```bash
   security delete-generic-password -s "seasnet-login-script"
   rm ~/.seaslogin_config
   ```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:

1. Check the [troubleshooting section](#troubleshooting)
2. Search existing [issues](https://github.com/OwenBattles/seaslogin/issues)
3. Create a new issue with detailed information

## Acknowledgments

- Built for the UCLA SEASnet community
- Uses macOS Keychain for secure credential storage
- Inspired by the need for a simple, secure SSH login utility

---

**Note**: This utility is designed specifically for SEASnet servers at UCLA. Modify the SSH connection details in the script if adapting for other servers.
