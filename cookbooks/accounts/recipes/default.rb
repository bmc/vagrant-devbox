gem_package "ruby-shadow" do
  action  :install
end

group node[:user]

user node[:user] do
  home      "/home/#{node[:user]}"
  group     node[:user]
  shell     "/bin/bash"
  supports  :manage_home => true
end

group "admin" do
  members [node[:user]]
  append  true
end

directory "/home/#{node[:user]}/.ssh" do
  owner   node[:user]
  group   node[:user]
  mode    0700
  action  :create
end

cookbook_file "/home/#{node[:user]}/.ssh/config" do
  source  "ssh_config"
  owner   node[:user]
  group   node[:user]
  mode    0600
end

