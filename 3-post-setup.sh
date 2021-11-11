#!/usr/bin/env bash

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~    FINAL SETUP AND CONFIGURATION    ~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""
echo ""
echo ""
echo "-------------------------------------------"
echo "    GRUB EFI BOOTLOADER INSTALL & CHECK    "
echo "-------------------------------------------"

if [[ -d "/sys/firmware/efi" ]]; then
    grub-install --efi-directory=/boot ${DISK}
fi
grub-mkconfig -o /boot/grub/grub.cfg

echo ""
echo "---------------------------------"
echo "    SET CUSTOM SYSTEM CONFIGS    "
echo "---------------------------------"

sudo cp $HOME/zxarch/sysconf/99-swappiness.conf /etc/sysctl.d/99-swappiness.conf

echo ""
echo "----------------------"
echo "    CONFIGURE SDDM    "
echo "----------------------"
echo -e "\nEnabling Login Display Manager"
systemctl enable sddm.service
echo -e "\nSetup SDDM Theme"
cat <<EOF > /etc/sddm.conf
[Theme]
Current=Vortex-SDDM
EOF

echo ""
echo "----------------------------"
echo "    CONFIGURING SERVICES    "
echo "----------------------------"

echo -e "\nEnabling essential services"

systemctl enable cups.service
ntpd -qg
systemctl enable ntpd.service
systemctl disable dhcpcd.service
systemctl stop dhcpcd.service
systemctl enable NetworkManager.service
systemctl enable bluetooth
systemctl enable btrfs-balance.timer
systemctl enable btrfs-trim.timer
echo ""
echo "-------------------------------------------"
echo "                  Cleaning                 "
echo "-------------------------------------------"

# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Replace in the same state
cd $pwd
echo ""
echo "---------------------------------------------"
echo " Done! Please Eject Install Media and Reboot "
echo "---------------------------------------------"

