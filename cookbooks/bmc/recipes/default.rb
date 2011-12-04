include_recipe "screen"

cookbook_file "/home/#{node[:vm_user]}/bootstrap.bash" do
  source "bootstrap.bash"
  owner  "#{node[:vm_user]}"
  group  "#{node[:vm_user]}"
  mode   0755
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
