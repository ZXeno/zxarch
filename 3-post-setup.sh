#!/usr/bin/env bash

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~    FINAL SETUP AND CONFIGURATION    ~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
source ${HOME}/zxarch/setup.conf
echo ""
echo ""
echo ""
echo "-------------------------------------------"
echo "    GRUB EFI BOOTLOADER INSTALL & CHECK    "
echo "-------------------------------------------"

if [[ -d "/sys/firmware/efi" ]]; then
    grub-install --efi-directory=/boot ${DISK}
fi

# set kernel parameter for decrypting the drive
if [[ "${FS}" == "luks" ]]; then
    sed -i "s%GRUB_CMDLINE_LINUX_DEFAULT=\"%GRUB_CMDLINE_LINUX_DEFAULT=\"cryptdevice=UUID=${ENCRYPTED_PARTITION_UUID}:ROOT root=/dev/mapper/ROOT %g" /etc/default/grub
fi
# set kernel parameter for adding splash screen
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& splash /' /etc/default/grub

echo -e "Updating grub..."
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
systemctl stop dhcpcd.servicezxarch
systemctl enable avahi-daemon.service
systemctl enable btrfs-balance.timer
systemctl enable btrfs-trim.timer
echo ""
echo "-------------------------------------------"
echo "                  Cleaning                 "
echo "-------------------------------------------"

# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

rm -r $HOME/zxarch
rm -r /home/$USERNAME/zxarch

# Replace in the same state
cd $pwd
echo ""
echo "---------------------------------------------"
echo " Done! Please Eject Install Media and Reboot "
echo "---------------------------------------------"
