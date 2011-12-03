#!/bin/sh
cd $HOME

echo "Initializing new SSH agent..."
# spawn ssh-agent
SSH_ENV=/tmp/ssh.$$
ssh-agent | sed 's/^echo/#echo/' > $SSH_ENV
echo succeeded
chmod 600 "$SSH_ENV"
. "$SSH_ENV" > /dev/null
ssh-add

# Read-only clones, to avoid copying private key into here.
[ -d bash ] || git clone git@github.com:bmc/bash.git

mkdir -p lib
(
cd lib;
[ -d bashlib ] || git clone git@github.com:bmc/bashlib.git;
[ -d emacs ] || git clone git@github.com:bmc/elisp.git emacs
)

# Autojump

mkdir -p $HOME/tmp
cd $HOME/tmp
rm -rf autojump
git clone git@github.com:bmc/autojump.git
mkdir $HOME/local
cd autojump
./install.sh --prefix $HOME/local
cd $HOME/tmp
rm -rf autojump

# My tools

mystuff=$HOME/src/mystuff
mkdir -p  $mystuff && cd $mystuff
[ -d misc-scripts ] || git clone git@github.com:bmc/misc-scripts.git
cd misc-scripts
rake
mkdir -p $HOME/bin
cd $HOME/bin
for i in $mystuff/misc-scripts/bin/* 
do
    [ -f $i ] || ln -s $i .
done

# .bashrc
cd $HOME
echo 'source $HOME/bash/bashrc' >$HOME/.bashrc

# Configure the dotfiles
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
