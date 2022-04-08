# virt-manager dotfiles
This repo explains how to install the Virt-manager virtualization environment,
in the most functional way possible, without excluding a practical automated
installation script, which will set up the service on **Arch Linux**, complete with
automatic assignment of user privileges.

## Setup
The first step is to clone the repo
```sh
git clone https://github.com/NF02/virt-manager-dotfiles && cd virt-manager-dotfiles
```
The second step is to grant the application the execution permissions,
to do that it is necessary to execute the command
```sh
chmod +x install-virtmenager.sh
```

### EFI Firmware
The UEFI firmware is a separate package compared to the virtualization 
environment, and for this reason I have included it in the script so that I can
fully exploit it. Of course the `HOST` machine can also be legacy because it
doesn't affect the `guest` system.

## Warning!!
This script is meant to be run with an admin user, so that can use admin
privileges via the `sudo` command, in case this utility is not installed
the script will not work.
