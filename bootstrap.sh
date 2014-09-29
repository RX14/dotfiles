#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed base base-devel git python3

mkdir ~/.ghar
cd ~/.ghar
git clone https://github.com/philips/ghar.git .
git clone https://github.com/RX14/dotfiles.git RX14

export BASE_X
export HOME_X

shopt -s dotglob
for X in ~/.ghar/RX14/*; do
    BASE_X=$( basename $X )
    HOME_X="/home/rx14/$BASE_X"
    echo "$HOME_X"
    rm -Rf "$HOME_X"
done
shopt -u dotglob

bin/ghar install

mkdir -p ~/bin
ln -s bin/* ~/bin/

echo "Installing Yaourt!"
sudo bash -c 'echo "
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch

[multilib]
Include = /etc/pacman.d/mirrorlist
" >> /etc/pacman.conf'
sudo pacman -Sy --noconfirm yaourt

yaourt -S --noconfirm openssh keychain bash-completion gh

if [ -z "$VAGRANT" ]; then
    echo "INSTALL GRAPHICS DRIVERS!"
    echo "Dropping into bash!"
    bash
fi

yaourt -S --noconfirm xorg-server xorg-xinit terminator i3 arandr i3blocks chromium

echo "TEST XORG: \$mod-shift-e to exit"
if [ -z "$VAGRANT" ]; then
    read
    startx
else
    echo "make a 'done' file to continue"
    while [ ! -f ~/done ]; do
        sleep 2
    done
fi

yaourt -S --noconfirm playonlinux bluez bluez-utils blueman thunderbird steam hexchat lightscreen-git dropbox skype ffmpeg livestreamer vlc spotify jdk ruby gradle atom maven ant intellij-idea-community-edition

echo "Installing RVM"
\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=rake,bundler

echo "All done!"
