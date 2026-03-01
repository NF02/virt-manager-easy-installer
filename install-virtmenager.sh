#!/bin/bash

# Funzione per verificare se un comando esiste
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Controllo privilegi
if ! command_exists sudo; then
    echo "Errore: sudo non è installato. Impossibile procedere."
    exit 1
fi

install_virt() {
    echo "Rilevamento distribuzione..."
    
    if command_exists pacman; then
        # Arch Linux - Usiamo -S e non -Sy per sicurezza
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
        echo "Distribuzione non supportata direttamente."
        exit 1
    fi

    # Abilitazione servizi
    sudo systemctl enable --now libvirtd.service

    # Aggiunta ai gruppi (usando $USER che è più portabile di whoami)
    sudo usermod -a -G libvirt "$USER"
    sudo usermod -a -G kvm "$USER"

    sudo systemctl restart libvirtd.service
    
    if command_exists notify-send; then
        notify-send "Installazione completata!"
    fi
    echo "Installazione finita. Riavvia la sessione (logout/login) per applicare i permessi del gruppo."
}

# Menu principale e gestione flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Uso: $0 [-y]"
    echo "-y : installazione automatica senza conferme"
    exit 0
fi

if [[ "$1" == "-y" ]]; then
    install_virt
    exit 0
fi

# Banner
cat << 'EOF'
 ╻ ╻╻┏━┓╺┳╸   ┏┳┓┏━┓┏┓╻┏━┓┏━╸┏━╸┏━┓   ╻┏┓╻┏━┓╺┳╸┏━┓╻  ╻  ┏━╸┏━┓
 ┃┏┛┃┣┳┛ ┃ ╺━╸┃┃┃┣━┫┃┗┫┣━┫┃╺┓┣╸ ┣┳┛   ┃┃┗┫┗━┓ ┃ ┣━┫┃  ┃  ┣╸ ┣┳┛
 ┗┛ ╹╹┗╸ ╹    ╹ ╹╹ ╹╹ ╹╹ ╹┗━┛┗━╸╹┗╸   ╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸┗━╸┗━╸╹┗╸
--------------------------------------------------------------
EOF

read -p "Vuoi installare l'ambiente virt-manager? (y/n): " con

case "$con" in
    [yY][eE][sS]|[yY]) 
        install_virt
        ;;
    *)
        echo "Uscita..."
        exit 1
        ;;
esac
