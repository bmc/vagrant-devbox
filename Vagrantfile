#                                                                 -*- ruby -*-
# Vagrantfile for general purpose development box.

Vagrant::Config.run do |config|

  # ---------------------------------------------------------------------------
  # Some variables
  # ---------------------------------------------------------------------------

  user = ENV['USER']
  vm_user = 'vagrant'
  home = ENV['HOME']

  # ---------------------------------------------------------------------------
  # Virtual machine configuration
  # ---------------------------------------------------------------------------

  config.vm.box = "oneiric64"
  config.vm.host_name = "dev"

  # Courtesy of Toby DiPasquale.
  config.vm.box_url = "http://dl.dropbox.com/u/3886896/oneiric64.box"


  config.vm.customize do |vm|
    vm.memory_size = 1536
  end

  # ---------------------------------------------------------------------------
  # SSH stuff.
  # ---------------------------------------------------------------------------

  # Load my current RSA or DSA SSH key and allow it to be copied up to
  # the virtual machine. This permits checkouts from private GitHub repos.
  sshdir = "#{home}/.ssh"
  if File.exists?("#{sshdir}/id_dsa") && File.exists?("#{sshdir}/id_dsa.pub")
    ssh_pub = "#{sshdir}/id_dsa.pub"
    ssh_priv = "#{sshdir}/id_dsa"
    ssh_key_type = "dsa"
  elsif File.exists?("#{sshdir}/id_rsa") && File.exists?("#{sshdir}/id_rsa.pub")
    ssh_pub = "#{sshdir}/id_rsa.pub"
    ssh_priv = "#{sshdir}/id_rsa"
    ssh_key_type = "rsa"
  else
    raise Exception.new("Can't find appropriate SSH key in #{sshdir}")
  end

  config.ssh.forward_agent = true

  # Set the private key path, so "vagrant ssh" won't prompt for a password.
  config.ssh.private_key_path = ssh_priv

  # ---------------------------------------------------------------------------
  # Port forwarding
  # ---------------------------------------------------------------------------

  config.vm.forward_port "rails", 3000, 3000
  
  # ---------------------------------------------------------------------------
  # Provisioning.
  # ---------------------------------------------------------------------------

  config.vm.provision :chef_solo do |chef|
    # Note to self: If you change this list of cookbooks, you either have to:
    #
    # a) run "vagrant reload", or
    # b) shut the VM down, destroy it, and recreate it.
    #
    # You can't just re-run "vagrant provision".
    #
    # See the section on "vagrant provision" at
    # http://vagrantup.com/docs/commands.html
    chef.cookbooks_path = ["cookbooks", "~/src/mystuff/chef-repo/cookbooks"]

    # Allow per-user overrides. The per-user recipes go in
    # cookbooks/$USER
    chef.json = {
      :vm_user         => vm_user,
      :ssh_public_key  => File.open(ssh_pub).read,
      :ssh_private_key => File.open(ssh_priv).read,
      :ssh_key_type    => ssh_key_type
    }
    chef.add_recipe "accounts"
    chef.add_recipe "build-essential"
    chef.add_recipe "screen"
    chef.add_recipe "base-development"
    chef.add_recipe "terminfo"
    chef.add_recipe "jdk6"
    chef.add_recipe user if File.directory?("cookbooks/#{user}")
  end
end