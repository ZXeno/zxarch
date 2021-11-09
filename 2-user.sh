#!/usr/bin/env bash

echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

echo "CLONING: YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ~

PKGS=(
'autojump'
'awesome-terminal-fonts'
'dxvk-bin' # DXVK DirectX to Vulcan
'gitkraken'
'nerd-fonts-fira-code'
'noto-fonts-emoji'
'plasma-pa'
'powershell-bin'
'ocs-url' # install packages from websites
'timeshift'
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

echo -e "Extracting the Vortex-Dark theme components to their target locations"
sudo mkdir -p /usr/share/aurorae/themes/Vortex-Aurorae
tar -xvf ${HOME}/zxarch/theme/Vortex-Aurorae.tar.gz -C ${HOME}/zxarch/theme
sudo cp -r ${HOME}/zxarch/theme/Vortex-Aurorae/* /usr/share/aurorae/themes/Vortex-Aurorae

sudo mkdir -p /usr/share/icons/Vortex-Dark
tar -xvf ${HOME}/zxarch/theme/Vortex-Dark-Icons.tar.gz -C ${HOME}/zxarch/theme
sudo cp -r ${HOME}/zxarch/theme/Vortex-Dark-Icons/* /usr/share/icons/Vortex-Dark

sudo mkdir -p /usr/share/themes/Vortex-Dark
tar -xvf ${HOME}/zxarch/theme/Vortex-GTK.tar.gz -C ${HOME}/zxarch/theme
sudo cp -r ${HOME}/zxarch/theme/Vortex-GTK/* /usr/share/themes/Vortex-Dark

sudo mkdir -p /usr/share/sddm/themes/Vortex-SDDM
tar -xvf ${HOME}/zxarch/theme/Vortex-SDDM.tar.gz -C ${HOME}/zxarch/theme
sudo cp -r ${HOME}/zxarch/theme/Vortex-SDDM/* /usr/share/sddm/themes/Vortex-SDDM

sudo mkdir -p /usr/share/plasma/look-and-feel/Vortex-Dark
tar -xvf ${HOME}/zxarch/theme/Vortex-Splash.tar.gz -C ${HOME}/zxarch/theme
sudo cp -r ${HOME}/zxarch/theme/Vortex-Splash/* /usr/share/plasma/look-and-feel/Vortex-Dark

sudo mkdir -p /usr/share/plasma/desktoptheme/Vortex-Dark
tar -xvf ${HOME}/zxarch/theme/Vortex-Plasma.tar.gz -C ${HOME}/zxarch/theme
sudo cp -r ${HOME}/zxarch/theme/Vortex-Plasma/Vortex/* /usr/share/plasma/desktoptheme/Vortex-Dark
sudo cp ${HOME}/zxarch/theme/Vortex-Plasma/Vortex/colors  /usr/share/color-schemes/Vortex-Dark.colors

echo -e "\nINSTALLING CUSTOM APPLICATIONS"

# copy all our custom icons
sudo cp ${HOME}/zxarch/icons/* /usr/share/icons

echo -e "\nApplying dotfiles"
export PATH=$PATH:~/.local/bin
cp -R $HOME/zxarch/dotfiles/. $HOME/
pip install konsave
konsave -i $HOME/zxarch/kde.knsv
sleep 1
konsave -a kde


mkdir -p ${HOME}/.local/share/bitwarden
wget -O bitwarden.appimage "https://vault.bitwarden.com/download/?app=desktop&platform=linux"
mv ${HOME}/bitwarden.appimage ${HOME}/.local/share/bitwarden/bitwarden.appimage

# make sure application shortcuts are properly configured
for f in ${HOME}/.local/share/applications/*
do
    sed -i "s|{{HOME}}|${HOME}|g" $f
done

echo -e "\nDone!\n"
exit
