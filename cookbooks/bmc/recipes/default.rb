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

cookbook_file "/home/#{node[:vm_user]}/bootstrap.bash" do
  source "bootstrap.bash"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0755
  not_if "test -e /home/#{node[:vm_user]}/bootstrap.bash"
end

cookbook_file "/home/#{node[:vm_user]}/.vagrant-dev.bash" do
  source "vagrant-dev.bash"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0755
  not_if "test -e /home/#{node[:vm_user]}/bash/vagrant-dev.bash"
end

cookbook_file "/home/#{node[:vm_user]}/.profile" do
  source "profile"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0644
end

package "python-pip"
package "python-virtualenv"
package "htop"

include_recipe "bmc::ssh"
