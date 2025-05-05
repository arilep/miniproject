# -*- mode: ruby -*-
# vi: set ft=ruby :
# Copyright 2019-2021 Tero Karvinen http://TeroKarvinen.com

$pcslave = <<PCSLAVE
set -o verbose
sudo apt-get update
sudo apt-get -y install curl
mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get -y install salt-minion
echo "master: 192.168.60.101" | sudo tee -a /etc/salt/minion
sudo systemctl restart salt-minion
echo "Done - set up test environment - https://terokarvinen.com/search/?q=vagrant"
PCSLAVE

$pcmaster = <<PCMASTER
set -o verbose
sudo apt-get update
sudo apt-get -y install curl
mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get -y install salt-master
sudo systemctl restart salt-master
echo "Done - set up test environment - https://terokarvinen.com/search/?q=vagrant"
PCMASTER

Vagrant.configure("2") do |config|
	config.vm.synced_folder ".", "/vagrant", disabled: true
	config.vm.synced_folder "shared/", "/home/vagrant/shared", create: true
	config.vm.box = "debian/bookworm64"

	config.vm.define "pcmaster" do |pcmaster|
		pcmaster.vm.provision :shell, inline: $pcmaster
		pcmaster.vm.hostname = "pcmaster"
		pcmaster.vm.network "private_network", ip: "192.168.60.101"
		pcmaster.vm.network "forwarded_port", guest: 19999, host: 29999
	end

	config.vm.define "pcslave", primary: true do |pcslave|
		pcslave.vm.provision :shell, inline: $pcslave
		pcslave.vm.hostname = "pcslave"
		pcslave.vm.network "private_network", ip: "192.168.60.102"
		pcslave.vm.network "forwarded_port", guest: 19999, host: 19999
	end
	
end