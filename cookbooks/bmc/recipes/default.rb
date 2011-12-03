include_recipe "screen"

cookbook_file "/home/bmc/bootstrap.bash" do
  source "bootstrap.bash"
  owner  "bmc"
  group  "bmc"
  mode   0755
end

cookbook_file "/home/bmc/.profile" do
  source "profile"
  owner  "bmc"
  group  "bmc"
  mode   0644
end

package "python-pip"
package "python-virtualenv"

include_recipe "bmc::ssh"
