#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Critical Check: Sudo Requirement
if ! command_exists sudo; then
    echo "Error: 'sudo' is not installed. This script requires admin privileges."
    exit 1
fi

install_virt() {
    echo "Detecting Package Manager..."
    
    if command_exists pacman; then
        # Arch Linux - Using --needed to avoid reinstalling existing packages
        sudo pacman -S --needed qemu-full virt-manager virt-viewer dnsmasq vde2 \
            openbsd-netcat ebtables iptables edk2-ovmf
        
    elif command_exists dnf; then
        # Fedora
        sudo dnf install -y @virtualization virt-manager
        
    elif command_exists apt; then
        # Debian/Ubuntu
        sudo apt update
        sudo apt install -y qemu-system libvirt-daemon-system libvirt-clients virt-manager
        
    else
        echo "Error: Your distribution is not supported by this script."
        exit 1
    fi

    # Enable and start services
    echo "Configuring Services..."
    sudo systemctl enable --now libvirtd.service

    # Add user to groups ($USER is more reliable than whoami)
    echo "Assigning User Privileges..."
    sudo usermod -a -G libvirt "$USER"
    sudo usermod -a -G kvm "$USER"

    # Restart service to apply changes
    sudo systemctl restart libvirtd.service
    
    if command_exists notify-send; then
        notify-send "Installation Complete!"
    fi
    
    echo "--------------------------------------------------------------"
    echo "DONE! Please LOG OUT and LOG IN again to apply group changes."
    echo "--------------------------------------------------------------"
}

# Help Menu
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    cat << 'EOF'
Virt-Manager Easy Installer
Usage: ./script.sh [options]

Options:
  -h, --help    Show this help message
  -y            Install automatically without asking
EOF
    exit 0
fi

# Auto-install flag
if [[ "$1" == "-y" ]]; then
    install_virt
    exit 0
fi

# ASCII Banner
cat << 'EOF'
╻ ╻╻┏━┓╺┳╸   ┏┳┓┏━┓┏┓╻┏━┓┏━╸┏━╸┏━┓   ╻┏┓╻┏━┓╺┳╸┏━┓╻  ╻  ┏━╸┏━┓
┃┏┛┃┣┳┛ ┃ ╺━╸┃┃┃┣━┫┃┗┫┣━┫┃╺┓┣╸ ┣┳┛   ┃┃┗┫┗━┓ ┃ ┣━┫┃  ┃  ┣╸ ┣┳┛
┗┛ ╹╹┗╸ ╹    ╹ ╹╹ ╹╹ ╹╹ ╹┗━┛┗━╸╹┗╸   ╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸┗━╸┗━╸╹┗╸
--------------------------------------------------------------
 * Easy Install | EFI Firmware | Multi-Distro Support
--------------------------------------------------------------
EOF

read -p "Do you want to install the Virt-manager environment? (y/n): " con

case "$con" in
    [yY][eE][sS]|[yY]) 
        install_virt
        ;;
    *)
        echo "Installation cancelled."
        exit 1
        ;;
esac
