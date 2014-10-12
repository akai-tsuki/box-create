#!/bin/bash

VAGRANT_USER=vagrant
VAGRANT_HOME=/home/${VAGRANT_USER}
VAGRANT_KEY_URL='https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'

#start
date > /tmp/vagrant_box_build_time

# configure sudoer
echo "Configure sudo"
sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# configure selinux
echo "Disable SELinux"
sudo /usr/sbin/setenforce 0
sudo sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

# installing packages
echo "Installing Packages"
# if use proxy
# sudo sh -c "echo proxy=http://192.168.1.1:xxxx >> /etc/yum.conf"
sudo yum install -y gcc make perl kernel-headers-`uname -r` kernel-devel-`uname -r` wget
sudo yum groupinstall -y 'Development tools'

# installing vagrant keys
echo "Installing Vagrant User Keys"
mkdir -pm 700 ${VAGRANT_HOME}/.ssh
# if use proxy
# export http_proxy=http://192.168.1.1:xxxx/
# export https_proxy=http://192.168.1.1:xxxx/
wget --no-check-certificate ${VAGRANT_KEY_URL} -O ${VAGRANT_HOME}/.ssh/authorized_keys
chmod 600 ${VAGRANT_HOME}/.ssh/authorized_keys
chown -R vagrant:vagrant ${VAGRANT_HOME}/.ssh
