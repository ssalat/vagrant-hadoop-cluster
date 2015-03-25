# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# /etc/hosts
#
# 192.168.66.10   hadoop-master.local
# 192.168.66.11   hadoop-backup.local
# 192.168.66.12   hadoop-slave1.local
# 192.168.66.13   hadoop-slave2.local
# ...
#

Vagrant::Config.run do |config|
  
  # SSH settings
  config.ssh.forward_agent = true
  
  # General settings
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
  # Shared folder
  config.vm.share_folder("vagrant-root", "/shared", "shared/", :nfs => true, :nfs_mount_options => ['dmode=777', 'fmode=777'])
  
  # Hadoop Master
  config.vm.define "hadoop-master", primary: true do |node|
    node.vm.host_name = "hadoop-master"
    node.vm.network :hostonly, "192.168.66.10"
    node.vm.customize ["modifyvm", :id, "--memory", 2048]
    node.vm.customize ["modifyvm", :id, "--name", "hadoop-master"]
  end
  
  # Hadoop Slaves
  (1..2).each do |i|
    config.vm.define "hadoop-slave#{i}" do |node|
      node.vm.host_name = "hadoop-slave#{i}"
      node.vm.network :hostonly, "192.168.66.#{i+10}"
      node.vm.customize ["modifyvm", :id, "--memory", 512]
      node.vm.customize ["modifyvm", :id, "--name", "hadoop-slave#{i}"]
    end
  end
  
  # Provisioning with Puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "puppet/modules"
    puppet.options = ["--debug", "--verbose"]
  end
  
end
