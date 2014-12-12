# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/centos-6.5-64-puppet"
  config.vm.hostname = 'puppet-riemann'
  config.vm.synced_folder "modules", "/tmp/puppet-modules", type: "rsync", rsync__exclude: ".git/"
  config.vm.synced_folder ".", "/tmp/puppet-modules/riemann", type: "rsync", rsync__exclude: ".git/"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "tests"
    puppet.manifest_file  = "vagrant.pp"
    puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
  end
end
