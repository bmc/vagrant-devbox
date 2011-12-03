maintainer        "Brian M. Clapper"
maintainer_email  "bmc@clapper.org"
license           "New BSD"
description       "Installs Java 6 JDK"
version           "0.1"

recipe "jdk6", "Installs Java 6 JDK"

%w{ ubuntu debian }.each do |os|
  supports os
end
