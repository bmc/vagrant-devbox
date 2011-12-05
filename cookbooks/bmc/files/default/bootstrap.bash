#!/bin/bash
cd $HOME

# ---------------------------------------------------------------------------
# SSH agent
# ---------------------------------------------------------------------------

echo "Initializing new SSH agent..."
# spawn ssh-agent
SSH_ENV=/tmp/ssh.$$
ssh-agent | sed 's/^echo/#echo/' > $SSH_ENV
echo succeeded
chmod 600 "$SSH_ENV"
. "$SSH_ENV" > /dev/null
ssh-add

# ---------------------------------------------------------------------------
# Main bash startup files
# ---------------------------------------------------------------------------

echo "Installing bash files."
[ ! -d bash ] || mv bash bash-
git clone git@github.com:bmc/bash.git
[ -d bash- ] && (cp bash-/* bash; rm -rf bash-)

# ---------------------------------------------------------------------------
# Bash library and Elisp stuff
# ---------------------------------------------------------------------------

echo "Installing bash library and Emacs Lisp files."
mkdir -p lib
(
cd lib;
[ -d bashlib ] || git clone git@github.com:bmc/bashlib.git;
[ -d emacs ] || git clone git@github.com:bmc/elisp.git emacs
)

# ---------------------------------------------------------------------------
# Autojump
# ---------------------------------------------------------------------------

echo "Installing autojump."
mkdir -p $HOME/tmp
cd $HOME/tmp
rm -rf autojump
git clone git@github.com:bmc/autojump.git
mkdir $HOME/local
cd autojump
./install.sh --prefix $HOME/local
cd $HOME/tmp
rm -rf autojump

# ---------------------------------------------------------------------------
# My tools
# ---------------------------------------------------------------------------

echo "Installing personal command line tools."
mystuff=$HOME/src/mystuff
mkdir -p  $mystuff && cd $mystuff
[ -d misc-scripts ] || git clone git@github.com:bmc/misc-scripts.git
cd misc-scripts
/usr/local/bin/rake bin
mkdir -p $HOME/bin
cd $HOME/bin
for i in $mystuff/misc-scripts/bin/* 
do
    rm -f `basename $i`
    ln -s $i .
done

# ---------------------------------------------------------------------------
# .bashrc
# ---------------------------------------------------------------------------

echo "Updating $HOME/.bashrc"
cd $HOME
echo 'source $HOME/bash/bashrc' >$HOME/.bashrc

# ---------------------------------------------------------------------------
# Install the dotfiles
# ---------------------------------------------------------------------------

echo "Installing dot files."
(
cd $HOME/lib
[ -d dotfiles ] || git clone git@github.com:bmc/dotfiles.git
)

for i in lib/dotfiles/*
do
    case "$i" in
        README*)
            ;;
        *)
            target=.`basename $i`
            rm -f $target
            ln -s $i $target
            ;;
    esac
done

echo "source ~/.bashrc" >$HOME/.profile

echo "**********************************************************************"
echo "Now, source ~/.bashrc, and you're ready to go."
echo "**********************************************************************"
