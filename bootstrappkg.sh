#/bin/bash
echo "Make sure you have ghar installed and RX14/dotfiles synced!"

echo "Installing Yaourt!"
sudo bash -c 'echo "[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf'
sudo pacman -Sy yaourt

yaourt -Syua
yaourt -S base-devel openssh keychain

echo "INSTALL GRAPHICS DRIVERS!"
echo "Dropping into bash!"
bash

yaourt -S xorg-server xorg-xinit terminator i3 arandr i3blocks chromium
echo "TEST XORG: \$mod-shift-e to exit"
read
startx

yaourt -S playonlinux bluez bluez-utils blueman thunderbird steam hexchat lightscreen-git dropbox skype ffmpeg livestreamer vlc spotify jdk ruby gradle atom maven ant intellij-idea-community-edition

echo "Installing RVM"
\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=rake,bundler

echo "All done!"
