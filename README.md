# Keyboard
    setxkbmap -layout fi -variant nodeadkeys
    setxkbmap -option 'caps:escape'
    mkdir -p $HOME/bin
    cp Xmodmap $HOME/bin
    echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.bashrc

# Some packages
    packages=(ncurses-dev git gitk xsel libx11-dev libxt-dev libgtk2.0-dev dbus-x11 python-dev)
    sudo apt-get install ${packages[@]}

# Vim
    git clone https://github.com/vim/vim
    cd vim
    ./configure --with-features=huge --enable-pythoninterp=dynamic --enable-gui=auto --with-x
    make
    sudo make install

# Install Vim Plugins
    mkdir -p $HOME/.vim/bundle
    cd $HOME/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim
    git clone https://github.com/jasu0/VimBox-rc
    ln -s $HOME/.vim/bundle/VimBox-rc/vimrc $HOME/.vimrc
    vim +PluginInstall +q

# PgAdmin 3
- Todo

# Java 8
    sudo vim /etc/apt/sources.list.d/java-8-debian.list
    deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
    sudo apt-get update
    sudo apt-get install oracle-java8-installer
    sudo apt-get install oracle-java8-set-default
