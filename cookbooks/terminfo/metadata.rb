maintainer        "Brian M. Clapper"
maintainer_email  "bmc@clapper.org"
license           "New BSD"
description       "Installs additional terminfo files"
version           "0.1"

recipe "terminfo", "Installs additional terminfo files"

%w{ redhat centos fedora ubuntu debian }.each do |os|
  supports os
end
