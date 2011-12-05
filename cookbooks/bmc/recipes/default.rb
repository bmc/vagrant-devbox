include_recipe "screen"

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

cookbook_file "/home/#{node[:vm_user]}/bash/vagrant-dev.sh" do
  source "vagrant-dev.sh"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0755
  not_if "test -e /home/#{node[:vm_user]}/bash/vagrant-dev.sh"
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
