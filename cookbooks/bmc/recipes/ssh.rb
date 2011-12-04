
file "/home/#{node[:vm_user]}/.ssh/authorized_keys" do
  owner   node[:vm_user]
  group   node[:vm_user]
  mode    0600
  content node[:ssh_public_key]
end

file "/home/#{node[:vm_user]}/.ssh/id_#{node[:ssh_key_type]}.pub" do
  owner   node[:vm_user]
  group   node[:vm_user]
  mode    0600
  content node[:ssh_public_key]
end

file "/home/#{node[:vm_user]}/.ssh/id_#{node[:ssh_key_type]}" do
  owner   node[:vm_user]
  group   node[:vm_user]
  mode    0600
  content node[:ssh_private_key]
end