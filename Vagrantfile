# -*- mode: ruby -*-
# vi: set ft=ruby :
# Use config.yaml for basic VM configuration.

require 'yaml'
dir = File.dirname(File.expand_path(__FILE__))
config_nodes = "#{dir}/artefacts/config/config_multi-nodes.yaml"

if !File.exist?("#{config_nodes}")
  raise 'Configuration file is missing! Please make sure that the configuration exists and try again.'
end
vconfig = YAML::load_file("#{config_nodes}")

BRIDGE_NET = vconfig['vagrant_ip']
DOMAIN = vconfig['vagrant_domain_name']
RAM = vconfig['vagrant_memory']

servers=[
  {
    :hostname => "nfsserver." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "150",
    :ram => 1024
  },
  {
    :hostname => "nfsclient." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "151",
    :ram => 1024
  },
  {
    :hostname => "docker." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "152",
    :ram => 2048 
  },
  {
    :hostname => "jenkins." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "153",
    :ram => "#{RAM}" 
  },
  {
    :hostname => "gitlab." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "154",
    :ram => "#{RAM}" 
  },
  {
    :hostname => "ansible." + "#{DOMAIN}",
    :ip => "#{BRIDGE_NET}" + "155",
    :ram => "#{RAM}",
	:install_ansible => "./artefacts/scripts/install_ansible.sh", 
	:config_ansible => "./artefacts/scripts/config_ansible.sh",
	:source =>  "./artefacts/.",
	:destination => "/home/vagrant/"
  }
]
 
Vagrant.configure(2) do |config|
    config.vm.synced_folder ".", vconfig['vagrant_directory'], :mount_options => ["dmode=777", "fmode=666"]
    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
			node.vm.box = vconfig['vagrant_box']
			node.vm.box_version = vconfig['vagrant_box_version']
			node.vm.hostname = machine[:hostname]
            node.vm.network "private_network", ip: machine[:ip] 
            node.vm.provider "virtualbox" do |vb|
                vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
				vb.cpus = vconfig['vagrant_cpu']
				vb.memory = machine[:ram]
                vb.name = machine[:hostname]
                if (!machine[:install_ansible].nil?)
                  if File.exist?(machine[:install_ansible])
					node.vm.provision :shell, path: machine[:install_ansible]
                  end
                  if File.exist?(machine[:config_ansible])
					node.vm.provision :file, source: machine[:source] , destination: machine[:destination]
      			    node.vm.provision :shell, privileged: false, path: machine[:config_ansible]
                  end
                end
            end
        end
    end
end
