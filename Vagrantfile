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
  ssh_pub = nil
  ssh_priv = nil
  ssh_target = nil
  %w(id_rsa id_dsa).each do |key|
    priv = "#{sshdir}/#{key}"
    pub = "#{sshdir}/#{key}.pub"
    if File.exists?(pub) && File.exists?(priv)
      ssh_pub = pub
      ssh_priv = priv
      ssh_target = File.basename(ssh_priv)
      break
    end
  end

  raise Exception.new("Can't find an SSH key in #{sshdir}") unless ssh_pub 
  
  config.ssh.forward_agent = true

  # ---------------------------------------------------------------------------
  # Port forwarding
  # ---------------------------------------------------------------------------

  # No additional ports right now.

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
      :vm_user  => vm_user,
      :rvm_user => vm_user,

      :ssh => {
         :public_key         => File.open(ssh_pub).read,
         :private_key        => File.open(ssh_priv).read,
         :public_key_source  => ssh_pub,
         :private_key_source => ssh_priv,
         :target             => ssh_target
      }
    }
    chef.add_recipe "accounts"
    chef.add_recipe "build-essential"
    chef.add_recipe "screen"
    chef.add_recipe "base-development"
    chef.add_recipe "terminfo"
    chef.add_recipe "rvm"
    chef.add_recipe "pythonbrew"
    chef.add_recipe user if File.directory?("cookbooks/#{user}")
  end
end
