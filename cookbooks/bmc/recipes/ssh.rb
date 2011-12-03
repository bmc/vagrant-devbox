
file "/home/#{node[:user]}/.ssh/authorized_keys" do
  owner   node[:user]
  group   node[:user]
  mode    0600
  content node[:ssh_public_key]
end

file "/home/#{node[:user]}/.ssh/id_#{node[:ssh_key_type]}.pub" do
  owner   node[:user]
  group   node[:user]
  mode    0600
  content node[:ssh_public_key]
end

file "/home/#{node[:user]}/.ssh/id_#{node[:ssh_key_type]}" do
  owner   node[:user]
  group   node[:user]
  mode    0600
  content node[:ssh_private_key]
end