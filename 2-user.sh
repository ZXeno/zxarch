#!/usr/bin/env bash

echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

echo "CLONING: YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ~

#zsh
# touch "$HOME/.cache/zshhistory"
# git clone "https://github.com/ChrisTitusTech/zsh"
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
# ln -s "$HOME/zsh/.zshrc" $HOME/.zshrc

PKGS=(
'autojump'
'awesome-terminal-fonts'
'dxvk-bin' # DXVK DirectX to Vulcan
'nerd-fonts-fira-code'
'noto-fonts-emoji'
'papirus-icon-theme'
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
'xcursor-sweet'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo -e "Extracting the Vortex-Dark theme components to their target locations"
sudo mkdir -p /usr/share/aurorae/themes/Vortex-Dark
tar -xvf /home/$username/zxarch/theme/Vortex-Aurorae.tar.gz -C /home/$username/zxarch/theme
sudo cp -r /home/$username/zxarch/theme/Vortex-Aurorae/* /usr/share/aurorae/themes/Vortex-Dark

sudo mkdir -p /usr/share/icons/Vortex-Dark
tar -xvf /home/$username/zxarch/theme/Vortex-Dark-Icons.tar.gz -C /home/$username/zxarch/theme
sudo cp -r /home/$username/zxarch/theme/Vortex-Dark-Icons/* /usr/share/icons/Vortex-Dark

sudo mkdir -p /usr/share/themes/Vortex-Dark
tar -xvf /home/$username/zxarch/theme/Vortex-GTK.tar.gz -C /home/$username/zxarch/theme
sudo cp -r /home/$username/zxarch/theme/Vortex-GTK/* /usr/share/themes/Vortex-Dark

sudo mkdir -p /usr/share/sddm/themes/Vortex-SDDM
tar -xvf /home/$username/zxarch/theme/Vortex-SDDM.tar.gz -C /home/$username/zxarch/theme
sudo cp -r /home/$username/zxarch/theme/Vortex-SDDM/* /usr/share/sddm/themes/Vortex-SDDM

sudo mkdir -p /usr/share/plasma/look-and-feel/Vortex-Dark
tar -xvf /home/$username/zxarch/theme/Vortex-Splash.tar.gz -C /home/$username/zxarch/theme
sudo cp -r /home/$username/zxarch/theme/Vortex-Splash/* /usr/share/plasma/look-and-feel/Vortex-Dark

echo -e "\nINSTALLING CUSTOM APPLICATIONS"

# copy all our custom icons
sudo cp /home/$username/zxarch/icons/* /usr/share/icons

mkdir -p /home/$username/.local/share/bitwarden
wget -O bitwarden.appimage "https://vault.bitwarden.com/download/?app=desktop&platform=linux"
mv /home/$username/zxarch/bitwarden.appimage $HOME/.local/share/bitwarden/bitwarden.appimage

echo -e "\nApplying dotfiles"
export PATH=$PATH:~/.local/bin
cp -R $HOME/zxarch/dotfiles/* $HOME/
pip install konsave
#konsave -i $HOME/zxarch/kde.knsv
#sleep 1
#konsave -a kde

echo -e "\nDone!\n"
exit
