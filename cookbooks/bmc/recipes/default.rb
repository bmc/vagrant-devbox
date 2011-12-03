include_recipe "screen"
include_recipe "bmc::ssh"

cookbook_file "/home/bmc/bootstrap.sh" do
  source "bootstrap.sh"
  owner  "bmc"
  group  "bmc"
  mode   0755
end
