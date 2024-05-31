#!/bin/env sh

command_exists() {
  command -v "$@" >/dev/null 2>&1
}
if ! command_exists sudo; then
	echo "sudo not install"
fi

install_virt() {
    # package install
    sudo xbps-install -y libvirt virt-manager qemu polkit

    # User mod
    sudo usermod -a -G libvirt,kvm $USER
    
    # config
    mkdir ~/.config/libvirt && sudo cp -rv /etc/libvirt/libvirt.conf ~/.config/libvirt/ && sudo chown $USER: ~/.config/libvirt/libvirt.conf
    echo "uri_default = \"qemu:///system\"" >> ~/.config/libvirt/libvirt.conf

    # enable services
    sudo ln -s /etc/sv/dbus /var/service/
    sudo ln -s /etc/sv/polkitd /var/service/
    sudo ln -s /etc/sv/libvirtd /var/service/
    sudo ln -s /etc/sv/virtlockd /var/service/
    sudo ln -s /etc/sv/virtlogd /var/service/
}

if [[ $1 == "-y" ]];then
	install_virt
	exit 0
fi

cat << 'EOF'
╻ ╻╻┏━┓╺┳╸   ┏┳┓┏━┓┏┓╻┏━┓┏━╸┏━╸┏━┓   ╻┏┓╻┏━┓╺┳╸┏━┓╻  ╻  ┏━╸┏━┓   ╻ ╻╻     ╻ ╻
┃┏┛┃┣┳┛ ┃ ╺━╸┃┃┃┣━┫┃┗┫┣━┫┃╺┓┣╸ ┣┳┛   ┃┃┗┫┗━┓ ┃ ┣━┫┃  ┃  ┣╸ ┣┳┛   ┃┏┛┃  ╺━╸┃┏┛
┗┛ ╹╹┗╸ ╹    ╹ ╹╹ ╹╹ ╹╹ ╹┗━┛┗━╸╹┗╸   ╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸┗━╸┗━╸╹┗╸   ┗┛ ┗━╸   ┗┛ 
-----------------------------------------------------------------------------
 * easy install
 * efi firmware
 * arm support
 * qemu extra
-----------------------------------------------------------------------------
Do you want to install the virt-manager environment (Yes or No)?
EOF
read con

if [[ $con == "yes" ]] || [[ $con == "y" ]];then
   	install_virt
   	exit 0
   else echo "exit!!!"
fi
