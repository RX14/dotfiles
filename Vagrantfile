# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "jfredett/arch-base"

    config.vm.provider :virtualbox do |vb|
        vb.gui = true

        vb.memory = 2048
        vb.cpus = 1
    end

    config.vm.provision "shell", path: "bootstrapvagrant.sh"

end
