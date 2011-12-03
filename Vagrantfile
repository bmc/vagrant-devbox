#                                                                 -*- ruby -*-
# Vagrantfile for general purpose development box.

Vagrant::Config.run do |config|
  config.vm.box = "oneiric64"
  #config.vm.box_url = "..."
  config.vm.host_name = "dev"

  config.vm.customize do |vm|
    vm.memory_size = 1536
  end

  #config.vm.forward_port "ssh", 22, 2222
  config.vm.forward_port "rails", 3000, 3000

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    # Allow per-user overrides. The per-user recipes go in
    # cookbooks/$USER
    chef.json = {:user => ENV['USER']}
    chef.add_recipe "build-essential"
    chef.add_recipe "screen"
    chef.add_recipe "basedev"
  end