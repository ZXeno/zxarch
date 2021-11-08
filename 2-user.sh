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

sh $HOME/zxarch/theme/install.sh

echo -e "\nINSTALLING CUSTOM APPLICATIONS"

# copy all our custom icons
cp $HOME/zxarch/icons/* /usr/share/icons

mkdir $HOME/.local/share/bitwarden
wget -O bitwarden.appimage "https://vault.bitwarden.com/download/?app=desktop&platform=linux"
mv $HOME/zxarch/bitwarden.appimage $HOME/.local/share/bitwarden/bitwarden.appimage


echo -e "\nApplying dotfiles"
export PATH=$PATH:~/.local/bin
cp -r $HOME/zxarch/dotfiles/* $HOME/
pip install konsave
#konsave -i $HOME/zxarch/kde.knsv
#sleep 1
#konsave -a kde

echo -e "\nDone!\n"
exit
