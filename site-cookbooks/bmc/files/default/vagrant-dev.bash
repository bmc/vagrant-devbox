# For vagrant development box.

# ---------------------------------------------------------------------------
# Misc. environment variables

export mystuff=$HOME/src/mystuff

# ---------------------------------------------------------------------------
# PATH

export PATH=\
$HOME/local/bin:\
$HOME/python/bin:\
/usr/bin:\
/bin:\
$PATH:\
/usr/local/sbin:\
/usr/sbin:\
/sbin:

# ---------------------------------------------------------------------------
# Aliases and functions

alias mllog="sudo tail -f /var/log/mail.log"
alias mslog="sudo tail -f /var/log/messages"
alias mystuff="varcd mystuff"
alias top=htop

load_file ~/bash/java.sh

# ---------------------------------------------------------------------------
# Local stuff

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib:$HOME/lib

load_file ~/etc/lib-sh/ssh.sh
