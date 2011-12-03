
cookbook_file "/lib/terminfo/x/xterm1"
  source "xterm1"
  owner  "root"
  group  "root"
  mode   0644
end

cookbook_file "/usr/share/terminfo/x/xterm1"
  source "xterm1"
  owner  "root"
  group  "root"
  mode   0644
end
