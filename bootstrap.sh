#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

THISFILE=`realpath "$0"`
FILENAME=`basename "$0"`

if [ "$USERNAME" == "root" ]; then
    groupadd -f sudo
    useradd -m -G sudo -s /bin/bash -U rx14

    cp "$THISFILE" /home/rx14/bootstrap.sh
    chown rx14:rx14 /home/rx14/bootstrap.sh
    chmod +x /home/rx14/bootstrap.sh

    echo "%sudo    ALL=(ALL) ALL" >> /etc/sudoers

    passwd rx14

    echo "Log into RX14 now and execute \"./bootstrap.sh\" [enter]"
    read
    exit 0
fi

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

sudo pacman -Sy --needed --noconfirm yaourt

yaourt -Syua --noconfirm
yaourt -S --noconfirm --needed base base-devel git python3 # pkg
yaourt -S --noconfirm --needed jdk # aur

rm -Rf ~/.ghar
mkdir -p ~/.ghar
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

yaourt -S --noconfirm --needed openssh keychain bash-completion
yaourt -S --noconfirm --needed gh

if [ -z "${VAGRANT:-}" ]; then
    echo "INSTALL GRAPHICS DRIVERS!"
    echo "Dropping into bash!"
    bash
fi

yaourt -S --noconfirm --needed xorg-server xorg-xinit roxterm i3 arandr chromium
yaourt -S --noconfirm i3blocks-git chromium-pepper-flash
echo "TEST XORG: \$mod-shift-e to exit [enter]"
if [ -z "${VAGRANT:-}" ]; then
    read
    startx
else
    echo "make a 'done' file to continue"
    while [ ! -f ~/done ]; do
        sleep 2
    done
fi

yaourt -S --noconfirm --needed alsa-utils alsa-plugins alsa-oss pulseaudio pavucontrol ponymix pulseaudio-alsa playonlinux bluez bluez-utils thunderbird steam hexchat skype ffmpeg ffmpeg-compat livestreamer vlc maven apache-ant wmctrl ttf-symbola ttf-ubuntu-font-family screen xorg-xmodmap aspell aspell-en xorg-xrdb
yaourt -S --noconfirm pasystray-git blueman lightscreen-git dropbox spotify gradle atom-editor ttf-inconsolata-dz resty whatpulse pkgcacheclean intellij-idea-ultimate-edition rubymine

if [ -z "${VAGRANT:-}" ]; then
    echo "EDIT THIS PKG [enter]"
    read
    yaourt -S lightscreen-git
fi

echo "Installing RVM"
\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=rake,bundler

echo "All done!"
