#!/bin/bash

    bash 0-preinstall.sh
    arch-chroot /mnt /root/zxarch/1-setup.sh
    source /mnt/root/zxarch/install.conf
    arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/zxarch/2-user.sh
    arch-chroot /mnt /root/zxarch/3-post-setup.sh

    # cleanup post script - uncomment after development
    rm -rf /mnt/home/$username/zxarch
    rm -rf /mnt/home/$username/yay
