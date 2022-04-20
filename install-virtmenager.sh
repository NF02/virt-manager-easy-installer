#!/bin/sh
command_exists() {
  command -v "$@" >/dev/null 2>&1
}
if ! command_exists sudo; then
	echo "sudo not install"
fi
install_virt() {
    	if command_exists pacman; then
		sudo pacman -Sy qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils \
	     		openbsd-netcat ebtables iptables ebtables iptables edk2-ovmf \
	     		qemu-arch-extra archboot-qemu-aarch64
	else if command_exists apt; then
		 apt install libvirt-deamon virt-manager qemu
	     else if command_exists dnf; then
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

echo "Do you want to install the virt-manager environment?"
read con

if [[ $con == "yes" ]];then
   	install_virt
   	exit 0
fi
