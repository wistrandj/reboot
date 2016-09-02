#!/bin/bash

if [[ $1 == '-f' ]] || [[ $1 == '--force' ]]; then
    ;
else
    set -e
fi

echo "$(date +'%d.%m.%Y %H:%M:%S') Setup keyboard layout"
setxkbmap -layout fi -variant nodeadkeys
setxkbmap -option 'caps:escape'
[[ -e Xmodmap ]] && cp Xmodmap $HOME/.Xmodmap

echo "$(date +'%d.%m.%Y %H:%M:%S') Install vim"
sudo apt-get install git
cd /tmp
git clone https://github.com/vim/vim
cd vim
./configure --with-features=huge --enable-pythoninterp=dynamic --enable-gui=auto --with-x
make
sudo make install
cd /tmp
rm -r vim

echo "$(date +'%d.%m.%Y %H:%M:%S') Vim plugins"
mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim
git clone https://github.com/jasu0/VimBox-rc
ln -s $HOME/.vim/bundle/VimBox-rc/vimrc $HOME/.vimrc
# Warning: this will hang with plugins without a repo
vim +PluginInstall +q
