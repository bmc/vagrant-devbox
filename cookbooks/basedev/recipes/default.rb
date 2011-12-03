# fix Ubuntu's incorrect major:minor numbers on /dev/u?random so Java apps don't hang forever
# execute "sudo rm /dev/urandom && sudo mknod -m 0644 /dev/random c 1 8" do
#   not_if 'ls -l /dev/urandom | grep -q "1, 8"'
# end
# execute "sudo rm /dev/random && sudo mknod -m 0644 /dev/random c 1 9" do
#   not_if 'ls -l /dev/random | grep -q "1, 9"'
# end

cookbook_file "/etc/sysctl.conf" do
  source  "sysctl.conf"
  owner   "root"
  group   "root"
  mode    0644
end

package "git-core"
package "ruby-dev"
package "rubygems"
package "curl"

gem_package "rake"
