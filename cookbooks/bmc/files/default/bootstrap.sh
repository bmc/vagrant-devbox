#!/bin/sh
cd $HOME
git clone git@github.com:bmc/bash.git
mkdir lib
cd lib
git clone git@github.com:bmc/bashlib.git
git clone git@github.com:bmc/elisp.git
git clone git@github.com:bmc/dotfiles.git

mkdir $HOME/tmp
cd $HOME/tmp
git clone git@github.com:bmc/autojump.git
mkdir $HOME/local
cd autojump
./install.sh --prefix $HOME/local

cd $HOME
echo 'source $HOME/bash/bashrc' >$HOME/.bashrc

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
