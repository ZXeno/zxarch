#!/usr/bin/env bash

echo ""
echo "-------------------------------"
echo "    INSTALLING AUR SOFTWARE    "
echo "-------------------------------"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

echo "Cloning YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ~

PKGS=(
'autojump'
'awesome-terminal-fonts'
'btrfsmaintenance'
'dxvk-bin' # DXVK DirectX to Vulcan
'gitkraken' # git gui
'nerd-fonts-fira-code'
'noto-fonts-emoji'
'plasma-pa'
'powershell-bin'
'ocs-url' # install packages from websites
'timeshift' # backup software
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-ms-fonts'
'ttf-roboto'
'visual-studio-code-bin'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo ""
echo "-------------------------------------------------------------"
echo " EXTRACTING VORTEX-DARK THEME COMPONENTS TO TARGET LOCATIONS "
echo "-------------------------------------------------------------"

sudo mkdir -p /usr/share/aurorae/themes/Vortex-Aurorae
tar -xf ${HOME}/zxarch/theme/Vortex-Aurorae.tar.gz -C ${HOME}/zxarch/theme
sudo cp -rv ${HOME}/zxarch/theme/Vortex-Aurorae/* /usr/share/aurorae/themes/Vortex-Aurorae

sudo mkdir -p /usr/share/icons/Vortex-Dark-Icons
tar -xf ${HOME}/zxarch/theme/Vortex-Dark-Icons.tar.gz -C ${HOME}/zxarch/theme
sudo cp -rv ${HOME}/zxarch/theme/Vortex-Dark-Icons/* /usr/share/icons/Vortex-Dark-Icons

sudo mkdir -p /usr/share/themes/Vortex-Dark
tar -xf ${HOME}/zxarch/theme/Vortex-GTK.tar.gz -C ${HOME}/zxarch/theme
sudo cp -rv ${HOME}/zxarch/theme/Vortex-GTK/* /usr/share/themes/Vortex-Dark

sudo mkdir -p /usr/share/sddm/themes/Vortex-SDDM
tar -xf ${HOME}/zxarch/theme/Vortex-SDDM.tar.gz -C ${HOME}/zxarch/theme
sudo cp -rv ${HOME}/zxarch/theme/Vortex-SDDM/* /usr/share/sddm/themes/Vortex-SDDM

sudo mkdir -p /usr/share/plasma/look-and-feel/Vortex-Dark
tar -xf ${HOME}/zxarch/theme/Vortex-Global.tar.gz -C ${HOME}/zxarch/theme
sudo cp -rv ${HOME}/zxarch/theme/Vortex-Global/* /usr/share/plasma/look-and-feel/Vortex-Dark

sudo mkdir -p /usr/share/plasma/desktoptheme/Vortex-Dark
tar -xf ${HOME}/zxarch/theme/Vortex-Plasma.tar.gz -C ${HOME}/zxarch/theme
sudo cp -rv ${HOME}/zxarch/theme/Vortex-Plasma/Vortex/* /usr/share/plasma/desktoptheme/Vortex-Dark
sudo cp ${HOME}/zxarch/theme/Vortex-Plasma/Vortex/colors  /usr/share/color-schemes/Vortex-Dark.colors

sudo mkdir -p /usr/share/wallpapers/zxarch
tar -xf ${HOME}/zxarch/theme/zxarch-Wallpapers.tar.gz -C ${HOME}/zxarch/theme
sudo cp -rv ${HOME}/zxarch/theme/zxarch-Wallpapers/*.png /usr/share/wallpapers
sudo cp -rv ${HOME}/zxarch/theme/zxarch-Wallpapers/*.jpg /usr/share/wallpapers

# copy all our custom icons
sudo cp -rv ${HOME}/zxarch/icons/* /usr/share/icons


echo ""
echo "-------------------------------------"
echo "    APPLYING DOTFILES & KDE CONFIG   "
echo "-------------------------------------"

# export PATH=$PATH:~/.local/bin
# pip install konsave
# konsave -i $HOME/zxarch/kde.knsv
# sleep 1
# konsave -a kde

cp -R $HOME/zxarch/dotfiles/. $HOME/

echo ""
echo "---------------------------------------"
echo "    INSTALLING NON-AUR APPLICATIONS    "
echo "---------------------------------------"

mkdir -p ${HOME}/.local/share/bitwarden
wget -O bitwarden.appimage "https://vault.bitwarden.com/download/?app=desktop&platform=linux"
mv ${HOME}/bitwarden.appimage ${HOME}/.local/share/bitwarden/bitwarden.appimage
chmod +rwx ${HOME}/.local/share/bitwarden/bitwarden.appimage

# make sure custom application shortcuts are properly configured
for f in ${HOME}/.local/share/applications/*
do
    sed -i "s|{{HOME}}|${HOME}|g" $f
done

echo -e "\nDone!\n"
exit
