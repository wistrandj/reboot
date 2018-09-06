# -*- mode: ruby -*-
# vi: set ft=ruby :

def setup_hostnames(node, vbox_name, hosts)
  etc_hosts = hosts.map{ |k, v| "#{v}  #{k}"}.join("\n")
  node.vm.provision "shell", inline: <<-SHELL
    hostname "#{vbox_name}"
    echo "#{vbox_name}" > /etc/hostname
    echo "#{etc_hosts}" >> /etc/hosts
  SHELL
end

Vagrant.configure("2") do |config|

  hosts = {
    "master": "10.1.1.100",
    "worker": "10.1.1.101",
  }
  ssh_keys = ["./keys/id_rsa", "C:/Users/#{ENV['USERNAME']}/.vagrant.d/insecure_private_key"]

  config.vm.define "master" do |node|
    vbox_name = "master"
    masterip = hosts[vbox_name]
    node.vm.box = "debian/stretch64"
    node.vm.network :private_network, type: "dhcp"
    node.vm.network :public_network, ip: "10.1.1.100"

    node.vm.provider :virtualbox do |vb|
      vb.name = vbox_name
      vb.gui = false
      vb.memory = "1024"
    end

    setup_hostnames(node, vbox_name, hosts)

  end

  config.vm.define "worker" do |node|
    vbox_name = "worker"
    node.vm.box = "debian/stretch64"
    node.vm.network :private_network, type: "dhcp"
    node.vm.network :public_network, ip: "10.1.1.101"

    node.vm.provider :virtualbox do |vb|
      vb.name = vbox_name
      vb.gui = false
      vb.memory = "4096"
    end

    setup_hostnames(node, vbox_name, hosts)

  end

  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   DEBIAN_FRONTEND=noninteractive apt-get install -y vim curl wget tree screen console-data
  # SHELL

  if File.file?(ssh_keys[0])
    # Generate SSH keys with following command
    # ssh-keygen.exe -f keys/id_rsa -t rsa
    config.ssh.private_key_path = ssh_keys.select{|key| File.file?(key)}

    config.ssh.insert_key = false
    config.vm.provision "file", source: "keys/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
    config.vm.provision "file", source: "keys/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
    config.vm.provision "file", source: "keys/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
    config.vm.provision "shell", inline: "chmod 0500 /home/vagrant/.ssh/id_rsa"
  end
end