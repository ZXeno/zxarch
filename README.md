# zxarch Installer Script

This README contains an increasingly modified version of the scripts ChrisTitusTech uses to perform an install and configure a fully-functional Arch Linux installation containing a desktop environment, all the support packages (network, bluetooth, audio, printers, etc.), along with preferred applications and utilities. The shell scripts in this repo allow the entire process to be automated.)

---
## Create Arch ISO or Use Image

Download ArchISO from <https://archlinux.org/download/> and put on a USB drive with Ventoy or Etcher

## Boot Arch ISO

From initial Prompt type the following commands:

```
pacman -Sy --noconfirm git 
git clone https://github.com/ZXeno/zxarch && cd zxarch &&./zxarch.sh
```

### System Description
This is completely automated arch install of the KDE desktop environment on arch. 

## Troubleshooting

__[Arch Linux Installation Guide](https://github.com/rickellis/Arch-Linux-Install-Guide)__

### No Wifi

#1: Run `iwctl`

#2: Run `device list`, and find your device name.

#3: Run `station [device name] scan`

#4: Run `station [device name] get-networks`

#5: Find your network, and run `station [device name] connect [network name]`, enter your password and run `exit`. You can test if you have internet connection by running `ping archlinux.org`. 

## Credits

- Original script(s) repo is located here: https://github.com/ChrisTitusTech/ArchTitus
- Thank you to Chris Titus of ChrisTitusTech for the script(s) and very helpful information made freely available to the community.
