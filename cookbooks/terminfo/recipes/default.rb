
# Copy "xterm1" terminfo file to both destinations.
%w(/lib/terminfo/x/xterm1).each do |dest|

  # Make sure the parent directory exists.
  dir = File.dirname dest
  directory dir do
    action :create
    owner  "root"
    group  "root"
    mode   0755
  end

  cookbook_file dest do
    action :create_if_missing
    source "xterm1"
    owner  "root"
    group  "root"
    mode   0644
  end
end
