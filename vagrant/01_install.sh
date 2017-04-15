#!/bin/bash

user_name="jasu"
user_password="vagrant"
guestadditions_version="5.1.16"
guestadditions_url="http://download.virtualbox.org/virtualbox/${guestadditions_version}/VBoxGuestAdditions_${guestadditions_version}.iso -O VBoxGuestAdditions_${guestadditions_version}.iso"

apt-get update -y
apt-get install -y git vim xfce4 xfce4-terminal wget sed lightdm
printf "\n" | pt-get install -y console-data
loadkeys fi
apt-get upgrade -y

# NOTE: With Vagrant, use plugins to automatically install guestadditions:
#  $ vagrant install plugin vagrant-vbguest
#  $ vagrant install plugin vagrant-share
# # Install guest additions for virtualbox
# apt-get install build-essential module-assistant linux-headers-$(uname -r) gcc make
# m-a prepare
# wget -c ${guestadditions_url}\
#    -O /opt/VBoxGuestAdditions_${guestadditions_version}.iso
# mount /opt/VBoxGuestAdditions_${guestadditions_version}.iso -o loop /mnt
# sh /mnt/VBoxLinuxAdditions.run --nox11
# # rm /opt/VBoxLinuxAdditions_${guestadditions_version}.iso

# Create user
useradd -m ${user_name}
usermod -a -G sudo ${user_name}
chsh -s /bin/bash ${user_name}
echo "${user_name}:${user_password}" | chpasswd

# Copy user home directory
mkdir -p /home/${user_name}/.config/
cp -r /vagrant/opt/user/xfce4 /home/${user_name}/.config/
chown -R ${user_name}:${user_name} /home/${user_name}
chmod 750 /home/${user_name}
# update-alternatives --config xfce4-terminal

# Configure LightDM
function copy_config() {
    path="$1"
    dir="$(dirname $path)"
    file="$(basename $path)"
    mkdir -p "$dir"
    chmod -R 755 "$dir"
    cp /vagrant/opt/"$file" "$dir"
}

copy_config "/etc/lightdm/lightdm.conf.d/10-autologin.conf"
sed -i "s/jasu/${user_name}/" /etc/lightdm/lightdm.conf.d/10-autologin.conf

copy_config "/etc/X11/xorg.conf.d/10-keyboard-layout.conf"
