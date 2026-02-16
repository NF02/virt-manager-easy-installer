#!/bin/sh
command_exists() {
  command -v "$@" >/dev/null 2>&1
}
if ! command_exists sudo; then
	echo "sudo not install"
fi
install_virt() {
    	if command_exists pacman; then
		sudo pacman -Sy qemu-full virt-manager virt-viewer dnsmasq vde2  \
	     		openbsd-netcat ebtables iptables ebtables iptables2 edk2-ovmf 
	else if command_exists apt; then # installer for Debian 
		 apt install libvirt-deamon virt-manager qemu
	     else if command_exists dnf; then # installer for Fedora
		      sudo dnf install @virtualization
		      else echo "I'm sorry"
		  fi
	     fi
	fi
	sudo systemctl enable --now libvirtd.service

	sudo usermod -a -G libvirt $(whoami)
	sudo usermod -a -G kvm $(whoami)

	sudo systemctl restart libvirtd.service
	notify-send "Done!"
}

if [[ $1 == --help ]] || [[ $1 == -h ]] || [[ $1 == -HELP ]]; then
	cat << 'EOF'
This script will install virt-manager and qemu with all necessary packages, 
obviously reading the documentation is recommended.
----------------------------------------------------------------------------
-                               commands                                   -
----------------------------------------------------------------------------

-y: continues without asking for consent (obviously the user's password will
be required)

EOF
	exit 0
fi


if [[ $1 == "-y" ]];then
	install_virt
	exit 0
fi

cat << 'EOF'
╻ ╻╻┏━┓╺┳╸   ┏┳┓┏━┓┏┓╻┏━┓┏━╸┏━╸┏━┓   ╻┏┓╻┏━┓╺┳╸┏━┓╻  ╻  ┏━╸┏━┓
┃┏┛┃┣┳┛ ┃ ╺━╸┃┃┃┣━┫┃┗┫┣━┫┃╺┓┣╸ ┣┳┛   ┃┃┗┫┗━┓ ┃ ┣━┫┃  ┃  ┣╸ ┣┳┛
┗┛ ╹╹┗╸ ╹    ╹ ╹╹ ╹╹ ╹╹ ╹┗━┛┗━╸╹┗╸   ╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸┗━╸┗━╸╹┗╸
--------------------------------------------------------------
 * easy install
 * efi firmware
 * arm support
 * distro supported - Arch Linux, Fedora and Debian
 * qemu extra
-------------------------------------------------------------- 
Do you want to install the virt-manager environment (Yes or No)?
EOF
read con

if [[ $con == "yes" ]] || [[ $con == "y" ]];then
   	install_virt
   	exit 0
   else echo "exit!!!"
fi
