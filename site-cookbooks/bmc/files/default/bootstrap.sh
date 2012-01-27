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

echo "Installing startup files files."
[ ! -d init-sh ] || mv init-sh init-sh-
git clone git@github.com:bmc/init-sh.git
[ -d init-sh- ] && (cp init-sh-/* init-sh; rm -rf init-sh-)

# ---------------------------------------------------------------------------
# Bash library and Elisp stuff
# ---------------------------------------------------------------------------

echo "Installing shell library and Emacs Lisp files."
mkdir -p lib
(
cd lib;
[ -d lib-sh ] || git clone git@github.com:bmc/lib-sh.git;
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
./install.zsh
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
# .bashrc and .zshrc
# ---------------------------------------------------------------------------

echo "Updating $HOME/.bashrc"
cd $HOME
echo 'source $HOME/init-sh/bashrc' >$HOME/.bashrc

echo "Updating $HOME/.zshrc"
cd $HOME
echo 'source $HOME/init-sh/zshrc' >$HOME/.bashrc

# ---------------------------------------------------------------------------
# .oh-my-zsh
# ---------------------------------------------------------------------------

echo "Installing Oh My Zsh"
cd $HOME
git clone https://github.com/robbyrussell/oh-my-zsh.git
mv oh-my-zsh .oh-my-zsh

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
echo "Now, source ~/.zshrc, and you're ready to go."
echo "**********************************************************************"
