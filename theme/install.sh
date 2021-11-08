#!/usr/bin/bash

echo -e "Extracting the Vortex-Dark theme components to their target locations"
mkdir /usr/share/aurorae/themes/Vortex-Dark
tar -xvf ./Vortex-Aurorae.tar.gz
cp -r ./Vortex-Aurorae/* /usr/share/aurorae/themes/Vortex-Dark

mkdir /usr/share/icons/Vortex-Dark
tar -xvf ./Vortex-Dark-Icons.tar.gz
cp -r ./Vortex-Dark-Icons/* /usr/share/icons/Vortex-Dark

mkdir /usr/share/themes/Vortex-Dark
tar -xvf ./Vortex-GTK.tar.gz
cp -r ./Vortex-GTK/* /usr/share/themes/Vortex-Dark

mkdir /usr/share/sddm/themes/Vortex-SDDM
tar -xvf ./Vortex-SDDM.tar.gz
cp -r ./Vortex-SDDM/* /usr/share/sddm/themes/Vortex-SDDM

mkdir /usr/share/plasma/look-and-feel/Vortex-Dark
tar -xvf ./Vortex-Splash.tar.gz
cp -r ./Vortex-Splash/* /usr/share/plasma/look-and-feel/Vortex-Dark