# configure sudoer
echo "Configure sudo"
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# installing packages
echo "Installing Packages"
# if use proxy
# sudo sh -c "echo proxy=http://192.168.1.1:xxxx >> /etc/yum.conf"
yum -y install gcc make gcc-c++ kernel-devel-`uname -r` perl

# installing vagrant keys
echo "Installing Vagrant User Keys"
mkdir -pm 700 /home/vagrant/.ssh
# if use proxy
# export http_proxy=http://192.168.1.1:xxxx/
# export https_proxy=http://192.168.1.1:xxxx/
curl -L https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

date > /etc/vagrant_box_build_time
