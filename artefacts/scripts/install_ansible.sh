#!/bin/sh

# Install Ansible repository.
apt -y update && apt-get -y upgrade
apt-get install software-properties-common
apt-add-repository ppa:ansible/ansible -y

# Install Ansible.
apt-get update
apt-get install ansible -y

# Install expect, dos2unix & tree
apt-get install expect -y 
apt-get install dos2unix -y
apt-get install tree -y 

#apt-get install python-pip -y

# Installing unzip
# apt-get install unzip -y 

# Cleanup unneded packages
apt-get -y autoremove

# Adjust timezone to be Singapore
ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# add user to sudo groups
# usermod -aG sudo vagrant

# lsb_release -a

# Add vagrant user to sudoers.
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Disable daily apt unattended updates.
#echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

# generating password configuration on ansible server to later access remote servers
echo vagrant | sudo -S su - vagrant -c "ssh-keygen -t rsa -f /home/vagrant/.ssh/id_rsa -q -P ''"

