#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

groupadd -f sudo
useradd -m -G sudo -s /bin/bash -U rx14

cp /vagrant/bootstrap.sh /home/rx14/
chmod +x /home/rx14/bootstrap.sh

echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

su rx14 -c "VAGRANT=1 /home/rx14/bootstrap.sh"
