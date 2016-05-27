# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "gbarbieru/xenial"

  config.landrush.enabled = true
  config.landrush.host_ip_address = '192.168.33.10'
  config.landrush.tld = 'sharebird.dev'

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 5432, host: 5432

  config.vm.synced_folder "./sharebird", "/vagrant_data/sharebird"

  config.vm.provision "file", source: "./ssl", destination: "/tmp"
  config.vm.provision "file", source: "./nginx", destination: "/tmp"
  config.vm.provision :shell, path: "bootstrap.sh", privileged: false
end
