# virt-manager dotfiles #
This repo explains how to install the Virt-manager virtualization environment,
in the most functional way possible, without excluding a practical automated
installation script, which will set up the service on **Arch Linux**, complete with
automatic assignment of user privileges.

## Setup ##
The first step is to clone the repo
```sh
git clone https://github.com/NF02/virt-manager-dotfiles && cd virt-manager-dotfiles
```
The second step is to grant the application the execution permissions,
to do that it is necessary to execute the command
```sh
chmod +x install-virtmenager.sh
```

*Obviously the execution permissions must be assigned manually, otherwise it does not
allow you to execute the parts it requires.*

### EFI Firmware ###
The UEFI firmware is a separate package compared to the virtualization 
environment, and for this reason I have included it in the script so that I can
fully exploit it. Of course the `HOST` machine can also be legacy because it
doesn't affect the `guest` system.
## Autoinstall ##
### curl ###
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/NF02/virt-manager-easy-installer/main/install-virtmenager.sh)"
```
### wget ###
```bash
 sh -c "$(wget https://raw.githubusercontent.com/NF02/virt-manager-easy-installer/main/install-virtmenager.sh -O -)"
```
## Warning!! ##
- This script is meant to be run with an admin user, so that can use admin
privileges via the `sudo` command, in case this utility is not installed
the script will not work.
- Another requirement is Systemd Init.

## Void Linux ##
There is a version of the script designed for Void Linux, as it uses Runit instead of Systemd, so a rewrite was mandatory.
### Autoinstall ###
#### curl ####
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/NF02/virt-manager-easy-installer/main/virtmenager-void-linux.sh)"
```

#### wget ####
```bash
 sh -c "$(wget https://raw.githubusercontent.com/NF02/virt-manager-easy-installer/main/virtmenager-void-linux.sh -O -)"
```