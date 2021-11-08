#!/usr/bin/bash

echo -e "Extracting the Vortex-Dark theme components to their target locations"
mkdir /usr/share/aurorae/themes/Vortex-Dark
tar -xvf $HOME/zxarch/theme/Vortex-Aurorae.tar.gz
cp -r $HOME/zxarch/theme/Vortex-Aurorae/* /usr/share/aurorae/themes/Vortex-Dark

mkdir /usr/share/icons/Vortex-Dark
tar -xvf $HOME/zxarch/theme/Vortex-Dark-Icons.tar.gz
cp -r $HOME/zxarch/theme/Vortex-Dark-Icons/* /usr/share/icons/Vortex-Dark

mkdir /usr/share/themes/Vortex-Dark
tar -xvf $HOME/zxarch/theme/Vortex-GTK.tar.gz
cp -r $HOME/zxarch/theme/Vortex-GTK/* /usr/share/themes/Vortex-Dark

mkdir /usr/share/sddm/themes/Vortex-SDDM
tar -xvf $HOME/zxarch/theme/Vortex-SDDM.tar.gz
cp -r $HOME/zxarch/theme/Vortex-SDDM/* /usr/share/sddm/themes/Vortex-SDDM

mkdir /usr/share/plasma/look-and-feel/Vortex-Dark
tar -xvf $HOME/zxarch/theme/Vortex-Splash.tar.gz
cp -r $HOME/zxarch/theme/Vortex-Splash/* /usr/share/plasma/look-and-feel/Vortex-Dark
