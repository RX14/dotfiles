#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

PACREPOS=$(sudo pacman -Sy)

if [[ ! $PACREPOS = *multilib* ]]; then
    echo "Installing multilib"
    sudo bash -c 'echo "
[multilib]
Include = /etc/pacman.d/mirrorlist
" >> /etc/pacman.conf'
fi

if [[ ! $PACREPOS = *archlinuxfr* ]]; then
    echo "Installing archlinuxfr"
    sudo bash -c 'echo "
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch
" >> /etc/pacman.conf'
fi

sudo pacman -Sy --noconfirm yaourt

yaourt -Syua --noconfirm
yaourt -S --noconfirm --needed base base-devel git python3 jdk

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
ln -sf $(pwd)/bin/* ~/bin/

yaourt -S --noconfirm openssh keychain bash-completion gh

if [ -z "$VAGRANT" ]; then
    echo "INSTALL GRAPHICS DRIVERS!"
    echo "Dropping into bash!"
    bash
fi

yaourt -S --noconfirm xorg-server xorg-xinit terminator i3 arandr i3blocks-git chromium chromium-pepper-flash

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

yaourt -S --noconfirm alsa-utils alsa-plugins alsa-oss pulseaudio pavucontrol pasystray-git ponymix pulseaudio-alsa playonlinux bluez bluez-utils blueman thunderbird steam hexchat lightscreen-git dropbox skype ffmpeg ffmpeg-compat livestreamer vlc spotify jdk jdk7 gradle atom-editor maven apache-ant intellij-idea-community-edition wmctrl ttf-inconsolata-dz ttf-symbola ttf-ubuntu-font-family

yaourt -R --noconfirm ruby
echo "Installing RVM"
\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=rake,bundler

echo "All done!"
