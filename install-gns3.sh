#!/bin/env sh
# Author: NFVblog <ask dot nfvblog at Outlook dot it>

# Check
command_exists() {
    command -v "$@" >/dev/null 2>&1
}

if ! command_exists sudo; then
    echo "sudo not install"
    exit -1 
fi

if ! command_exists git; then
    echo "git not install"
    exit -3
fi

if ! command_exists yay; then
    cd /tmp && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
fi
if ! command_exists qemu-x86_64;then
    echo "qemu not install"
fi


# Install GNS3 by YAY AUR Helper
install_gns3(){
    yay -S busybox python-aiofiles python-aiohttp python-aiohttps-cors \
	python-async-timeout python-distro python-jsonschema \
	python-platformdirs python-psutil python-py-cpuinfo python-sentry_sdk \
	python-setuptools python-truststore dynamips ubridge vpcs gns3-gui \
	gns3-server
}

cat << 'EOF'
┏━╸┏┓╻┏━┓┏━┓   ╻┏┓╻┏━┓╺┳╸┏━┓╻  ╻  ┏━╸┏━┓
┃╺┓┃┗┫┗━┓╺━┫   ┃┃┗┫┗━┓ ┃ ┣━┫┃  ┃  ┣╸ ┣┳┛
┗━┛╹ ╹┗━┛┗━┛   ╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸┗━╸┗━╸╹┗╸
--------------------------------------------------------------
 * install GNS3 server and GUI;
 * dynamips support;
 * vpcs support;
 * ubridge support.
-------------------------------------------------------------- 
Do you want to install the GNS3 environment (Yes or No)?
EOF
read con

if [[ $con == "yes" ]] || [[ $con == "y" ]];then
   	install_gns3
   	exit 0
   else echo "exit!!!"
fi
