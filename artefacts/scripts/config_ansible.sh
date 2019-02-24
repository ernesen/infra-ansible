#!/bin/sh

USER=vagrant
PASSWORD=vagrant

# wget https://releases.hashicorp.com/packer/1.3.4/packer_1.3.4_linux_amd64.zip
# unzip packer_1.3.4_linux_amd64.zip -d /tmp/packer
# sudo mv /tmp/packer/packer /usr/local/
# export PATH="$PATH:/usr/local/packer"
# source /etc/environment

# add addresses to /etc/hosts 
echo "192.168.99.155 ansible.sample.com" | sudo tee -a /etc/hosts 
echo "192.168.99.154 gitlab.sample.com" | sudo tee -a /etc/hosts 
echo "192.168.99.153 jenkins.sample.com" | sudo tee -a /etc/hosts 
echo "192.168.99.152 docker.sample.com" | sudo tee -a /etc/hosts 
echo "192.168.99.151 nfsclient.sample.com" | sudo tee -a /etc/hosts
echo "192.168.99.150 nfsserver.sample.com" | sudo tee -a /etc/hosts  

echo " " | sudo tee -a /etc/ansible/hosts
echo "[all]" | sudo tee -a /etc/ansible/hosts
echo "gitlab.sample.com" | sudo tee -a /etc/ansible/hosts 
echo "jenkins.sample.com" | sudo tee -a /etc/ansible/hosts 
echo "docker.sample.com" | sudo tee -a /etc/ansible/hosts 
echo "nfsclient.sample.com" | sudo tee -a /etc/ansible/hosts
echo "nfsserver.sample.com" | sudo tee -a /etc/ansible/hosts  

echo " " | sudo tee -a /etc/ansible/hosts
echo "[test]" | sudo tee -a /etc/ansible/hosts
echo "nfsserver.sample.com" | sudo tee -a /etc/ansible/hosts
echo "nfsclient.sample.com" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[nfs-server]" | sudo tee -a /etc/ansible/hosts
echo "nfsserver.sample.com" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[nfs-clients]" | sudo tee -a /etc/ansible/hosts
echo "nfsclient.sample.com" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[jenkins]" | sudo tee -a /etc/ansible/hosts
echo "jenkins.sample.com" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[docker]" | sudo tee -a /etc/ansible/hosts
echo "docker.sample.com" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[gitlab]" | sudo tee -a /etc/ansible/hosts
echo "gitlab.sample.com" | sudo tee -a /etc/ansible/hosts

#cat /etc/ansible/hosts
dos2unix ~/artefacts/scripts/ssh_pass.sh
chmod +x ~/artefacts/scripts/ssh_pass.sh
#chown vagrant:vagrant ssh_pass.sh 

# password less authentication using expect scripting language
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "ansible.sample.com" 
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "nfsclient.sample.com" 
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "nfsserver.sample.com" 
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "docker.sample.com" 
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "jenkins.sample.com"
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "gitlab.sample.com"

ansible-playbook ~/artefacts/playbooks/nfs_server.yaml
ansible-playbook ~/artefacts/playbooks/nfs_clients.yaml
ansible-playbook ~/artefacts/playbooks/install_java.yaml
ansible-playbook ~/artefacts/playbooks/install_jenkins.yaml
ansible-playbook ~/artefacts/playbooks/install_docker.yaml
ansible-playbook ~/artefacts/playbooks/install_gitlab.yaml


