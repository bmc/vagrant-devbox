bash "Updating APT repository" do
  user node[:vm_user]
  code 'sudo apt-get -y update'
end
