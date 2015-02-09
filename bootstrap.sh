#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

THISFILE=`realpath "$0"`
FILENAME=`basename "$0"`

if [ "$USERNAME" == "root" ]; then
    pacman -S zsh
    groupadd -f sudo
    useradd -m -G sudo -s /bin/zsh -U rx14

    cp "$THISFILE" /home/rx14/bootstrap.sh
    chown rx14:rx14 /home/rx14/bootstrap.sh
    chmod +x /home/rx14/bootstrap.sh

    echo "%sudo    ALL=(ALL) ALL" >> /etc/sudoers

    passwd rx14

    echo "Log into RX14 now and execute \"./bootstrap.sh\" [enter]"
    read
    exit 0
fi

function install_pacman_repo() {
    if [[ ! $PACREPOS = "*$1*" ]]; then
        echo "Installing $1"
        sudo bash -c "echo \"$2\" >> /etc/pacman.conf"
    fi
}

PACREPOS=$(sudo pacman -Sy)

install_pacman_repo multilib "
[multilib]
Include = /etc/pacman.d/mirrorlist
"

install_pacman_repo archlinuxfr "
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch
"

sudo pacman -Sy --needed --noconfirm yaourt

yaourt -Syua --noconfirm
yaourt -S --noconfirm --needed base base-devel git # pkg
yaourt -S --noconfirm --needed jdk # aur

echo "Installing RVM"
\curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=rake,bundler,homesick

source ~/.rvm/scripts/rvm

homesick clone RX14/dotfiles
mv ~/.homesick/repos/dotfiles/ ~/.homesick/repos/rx14
homesick link rx14 --force

yaourt -S --noconfirm --needed openssh keychain
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

echo "All done!"
