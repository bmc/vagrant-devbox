#                                                                 -*- ruby -*-
# Vagrantfile for general purpose development box.

Vagrant::Config.run do |config|
  config.vm.box = "oneiric64"
  config.vm.host_name = "dev"

  # Courtesy of Toby DiPasquale.
  config.vm.box_url = "http://dl.dropbox.com/u/3886896/oneiric64.box"

  config.vm.customize do |vm|
    vm.memory_size = 1536
  end

  #config.vm.forward_port "ssh", 22, 2222
  config.vm.forward_port "rails", 3000, 3000

  user = ENV['USER']
  home = ENV['HOME']
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"

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

    # Allow per-user overrides. The per-user recipes go in
    # cookbooks/$USER
    chef.json = {
      :user            => user,
      :ssh_public_key  => File.open(ssh_pub).read,
      :ssh_private_key => File.open(ssh_priv).read,
      :ssh_key_type    => ssh_key_type
    }
    chef.add_recipe "accounts"
    chef.add_recipe "build-essential"
    chef.add_recipe "screen"
    chef.add_recipe "basedev"
    chef.add_recipe "terminfo"
    chef.add_recipe "jdk6"
    chef.add_recipe user if File.directory?("cookbooks/#{user}")
  end
end