
cookbook_file "/home/#{node[:user]}/.ssh/authorized_keys" do
  source  "ssh/authorized_keys"
  owner   node[:user]
  group   node[:user]
  mode    0600
end

