gem_package "ruby-shadow" do
  action  :install
end

group node[:vm_user]

user node[:vm_user] do
  home      "/home/#{node[:vm_user]}"
  group     node[:vm_user]
  shell     "/bin/bash"
  supports  :manage_home => true
end

group "admin" do
  members [node[:vm_user]]
  append  true
end

directory "/home/#{node[:vm_user]}/.ssh" do
  owner   node[:vm_user]
  group   node[:vm_user]
  mode    0700
  action  :create
end

cookbook_file "/home/#{node[:vm_user]}/.ssh/config" do
  source  "ssh_config"
  owner   node[:vm_user]
  group   node[:vm_user]
  mode    0600
end

