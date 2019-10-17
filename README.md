Reboot
======

VirtualBox guest additions
--------------------------

Needed for graphical interface and for synced folders. Install the Vagrant plugin

    $ vagrant plugin install vagrant-vbguest

Setup more Video RAM from VirtualBox settings. 32MB is a good amount.


Problems
--------

If provisioning fails to install specific kernel-headers version, you have
install newer linux kernel. This might happen with vbguest plugin if the
Vagrant box falls out of date. Bring the machine up with

    $ vagrant up --no-provision

Log in and check newer kernel (Debian)

    $ vagrant ssh
    [vagrant@stretch] $ apt-cache search linux-image
    linux-image-4.9.0-11-amd64
    ...

Install the newer image

    [vagrant@stretch] $ apt-get install -y linux-image-4.9.0-11-amd64

Try to provisioning again

    $ vagrant reload

