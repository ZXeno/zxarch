#!/bin/bash
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
set +a

( bash $SCRIPT_DIR/startup.sh )|& tee startup.log
    source $CONFIGS_DIR/setup.conf
( bash $SCRIPT_DIR/0-preinstall.sh )|& tee 0-preinstall.log
( arch-chroot /mnt $HOME/zxarch/1-setup.sh )|& tee 1-setup.log
if [[ ! $DESKTOP_ENV == server ]]; then
    ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/zxarch/2-user.sh )|& tee 2-user.log
fi
( arch-chroot /mnt $HOME/zxarch/3-post-setup.sh )|& tee 3-post-setup.log
cp -v *.log /mnt/home/$USERNAME

# cleanup post script - uncomment after development
rm -rf /mnt/home/$username/zxarch
rm -rf /mnt/home/$username/yay
