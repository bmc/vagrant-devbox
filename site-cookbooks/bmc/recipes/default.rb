include_recipe "screen"

cookbook_file "/etc/profile.d/vagrant-box.sh" do
  action :create
  source "etc-profiled-vagrant.sh"
  owner  "root"
  mode   0644
  not_if "test -f /etc/profile.d/vagrant-box.sh"
end

directory "/home/#{node[:vm_user]}/bash" do
  action :create
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0755
  not_if "test -d /home/#{node[:vm_user]}/bash"
end

cookbook_file "/home/#{node[:vm_user]}/bootstrap.sh" do
  source "bootstrap.sh"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0755
  not_if "test -e /home/#{node[:vm_user]}/bootstrap.sh"
end

cookbook_file "/home/#{node[:vm_user]}/.vagrant-dev.sh" do
  source "vagrant-dev.sh"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0755
  not_if "test -e /home/#{node[:vm_user]}/init-sh/vagrant-dev.sh"
end

cookbook_file "/home/#{node[:vm_user]}/.profile" do
  source "profile"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0644
end

cookbook_file "/home/#{node[:vm_user]}/.zshrc" do
  source "zshrc"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0644
end

package 'zsh' do
  action :install
  not_if "test -e /usr/bin/zsh"
end

PACKAGES = %w(
  ack-grep
  python-pip
  python-virtualenv
  htop
  libedit-dev
  openjdk-6-jdk
  unzip
  vim
  zip
  zsh
)
PACKAGES.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe "bmc::ssh"
