#!/usr/bin/env bash

echo ""
echo "-------------------------------"
echo "    INSTALLING AUR SOFTWARE    "
echo "-------------------------------"
source $HOME/zxarch/setup.conf

echo "Cloning $AUR_HELPER"
cd ~
git clone "https://aur.archlinux.org/$AUR_HELPER.git"
cd ${HOME}/$AUR_HELPER
makepkg -si --noconfirm
cd ~

sed -n '/'$INSTALL_TYPE'/q;p' ~/zxarch/aur-pkgs.txt | while read line
do
    echo "INSTALLING: ${line}"
    $AUR_HELPER -S --noconfirm ${line}
done
export PATH=$PATH:~/.local/bin


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
cp -R $HOME/zxarch/dotfiles/. $HOME/

echo ""
echo "---------------------------------------"
echo "    INSTALLING NON-AUR APPLICATIONS    "
echo "---------------------------------------"

echo ""
echo "Installing Dotnet"
curl -sSL https://dot.net/v1/dotnet-install.sh | sudo bash /dev/stdin -c LTS --install-dir /usr/share/dotnet
sudo ln -sf /usr/share/dotnet/dotnet /usr/bin/dotnet

# make sure custom application shortcuts are properly configured
for f in ${HOME}/.local/share/applications/*
do
    sed -i "s|{{HOME}}|${HOME}|g" $f
done

echo -e "\nDone!\n"
exit

