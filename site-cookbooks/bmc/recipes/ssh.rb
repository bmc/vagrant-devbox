
cookbook_file "/home/#{node[:vm_user]}/.ssh/authorized_keys" do
  owner   node[:vm_user]
  group   node[:vm_user]
  mode    0600
  source  "ssh/authorized_keys"
end

file "/home/#{node[:vm_user]}/.ssh/#{node[:ssh][:target]}.pub" do
  owner   node[:vm_user]
  group   node[:vm_user]
  mode    0600
  content node[:ssh][:public_key]
end

file "/home/#{node[:vm_user]}/.ssh/#{node[:ssh][:target]}" do
  owner   node[:vm_user]
  group   node[:vm_user]
  mode    0600
  content node[:ssh][:private_key]
end