#!/bin/bash

keyurl="http://ppa.launchpad.net/ansible/ansible/ubuntu"
path="/etc/apt/sources.list.d/ansible.list"

echo "deb $keyurl trusty main" > $path
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get update -y
apt-get install -y ansible
