# -*- mode: ruby -*-
# vi: set ft=ruby :

# You can generate a SSH key before provisioning
#
#   $ ssh-keygen.exe -f keys/id_rsa -t rsa
#

vbox_name = File.basename(Dir.pwd)
vbox_ip = '10.0.0.1'
vbox_ram = '4096'
vbox_os = "debian/stretch64"

base_packages       = ''
additional_packages = ''
synced_folder       = './sync'
forwarded_ports     = [
    # { :client => 3001, :host => 3001 }
]

# Set true to copy the private key from host ($HOME/.ssh/id_rsa) to client
# Security: By default, set to false
Use_personal_ssh_key = false


def provide_ssh_key()
  host_username = [ENV["USER"], ENV["USERNAME"]].detect{ |uname| uname }

  personal_ssh_key = ENV["HOME"] + "/.ssh/id_rsa"

  possible_private_keys = [
      Use_personal_ssh_key ? personal_ssh_key : nil,
      "./keys/id_rsa",
      "/home/#{host_username}/.vagrant.d/insecure_private_key",
      "/Users/#{host_username}/.vagrant.d/insecure_private_key",
      "C:/Users/#{host_username}/.vagrant.d/insecure_private_key",
  ]

  return possible_private_keys.detect{ |key| key and File.file?(key) }
end



def setup_hostname(node, vbox_name)
  node.vm.provision "shell", inline: <<-SHELL
    hostname "#{vbox_name}"
    echo "#{vbox_name}" > /etc/hostname
  SHELL
end


def setup_hosts_file(node, vbox_name, hosts)
  etc_hosts = hosts.map{ |name, ip| "#{ip}  #{name}"}.join("\n")
  node.vm.provision "shell", inline: <<-SHELL
    echo "#{etc_hosts}" >> /etc/hosts
  SHELL
end


def provisioned?(name)
  # Hack: It tells if this VM has been provisioned once and the possible private key is copied to client
  File.file?(".vagrant/machines/#{name}/virtualbox/action_provision")
end


Vagrant.configure("2") do |config|

  # Additional hosts to be written in hosts file
  hosts = {
    vbox_name: vbox_ip,
  }

  # Build the virtual machine
  config.vm.define vbox_name do |node|
    vbox_name = vbox_name
    node.vm.box = vbox_os
    node.vm.network :private_network, type: "dhcp"
    node.vm.network :public_network, ip: vbox_ip

    forwarded_ports.each do |defn|
      client_port = defn[:client]
      host_port   = defn[:host]
      node.vm.network :forwarded_port, guest: client_port, host: host_port
    end

    # Synced folders require guestadditions
    if synced_folder and Dir.exists?(synced_folder)
      node.vm.synced_folder synced_folder, "/#{File.basename(synced_folder)}", owner: 'vagrant', group: 'vagrant'
    end

    node.vm.provider :virtualbox do |vb|
      vb.name = vbox_name
      vb.gui = false
      vb.memory = vbox_ram
    end

    setup_hostname(node, vbox_name)
    setup_hosts_file(node, vbox_name, hosts)

  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y #{base_packages} #{additional_packages}
    ip a | grep 'inet [0-9]'
  SHELL

  private_key = provide_ssh_key()

  if provisioned?(vbox_name) and private_key != nil
    # The VM was provisioned once and the custom private key was copied to client. Until that, we use the insecure_private_key
    config.ssh.private_key_path = private_key
  end

  if not provisioned?(vbox_name) and private_key != nil
    id_rsa          = '/home/vagrant/.ssh/id_rsa'
    id_rsa_pub      = '/home/vagrant/.ssh/id_rsa.pub'
    authorized_keys = '/home/vagrant/.ssh/authorized_keys'

    # Q: Why is this false?
    config.ssh.insert_key = false
    config.vm.provision "file", source: private_key, destination: id_rsa
    config.vm.provision "shell", inline: "chmod 0400 #{id_rsa}"
    config.vm.provision "shell", inline: "ssh-keygen -y -f #{id_rsa} > #{id_rsa_pub}"
    config.vm.provision "shell", inline: "cp #{id_rsa_pub} #{authorized_keys}"
  end
end
