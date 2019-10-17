# -*- mode: ruby -*-
# vi: set ft=ruby :

# You can generate a SSH key before provisioning
#
#   $ ssh-keygen.exe -f keys/id_rsa -t rsa
#


def setup_hostnames(node, vbox_name, hosts)
  # Set up hostname and /etc/hosts file
  etc_hosts = hosts.map{ |k, v| "#{v}  #{k}"}.join("\n")
  node.vm.provision "shell", inline: <<-SHELL
    hostname "#{vbox_name}"
    echo "#{vbox_name}" > /etc/hostname
    echo "#{etc_hosts}" >> /etc/hosts
  SHELL
end


Vagrant.configure("2") do |config|

  # Set virtual machine's infomation
  vbox_name = 'master'
  vbox_ip = '10.0.0.1'
  vbox_ram = '4096'
  vbox_os = "debian/stretch64"
  base_packages = 'vim curl wget tree screen console-data'
  additional_packages = ''

  # Additional hosts to be written in hosts file
  hosts = {
    vbox_name: vbox_ip,
  }

  # If the first key exists, copy it for the user
  ssh_keys = ["./keys/id_rsa", "C:/Users/#{ENV['USERNAME']}/.vagrant.d/insecure_private_key"]

  # Build the virtual machine
  config.vm.define vbox_name do |node|
    vbox_name = vbox_name
    node.vm.box = vbox_os
    node.vm.network :private_network, type: "dhcp"
    node.vm.network :public_network, ip: vbox_ip

    # Set additional forwarded ports. During provisioning, the ip command shows the IP that can be connected from the host OS.
    # node.vm.network :forwarded_port, guest: 3000, host: 3000

    node.vm.provider :virtualbox do |vb|
      vb.name = vbox_name
      vb.gui = false
      vb.memory = vbox_ram
    end

    setup_hostnames(node, vbox_name, hosts)

  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y #{base_packages} #{additional_packages}
    ip a | grep 'inet [0-9]'
  SHELL

  if File.file?(ssh_keys[0])
    # If the provided key exists, use it
    config.ssh.private_key_path = ssh_keys.select{|key| File.file?(key)}

    config.ssh.insert_key = false
    config.vm.provision "file", source: "keys/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
    config.vm.provision "file", source: "keys/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
    config.vm.provision "file", source: "keys/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
    config.vm.provision "shell", inline: "chmod 0500 /home/vagrant/.ssh/id_rsa"
  end
end
