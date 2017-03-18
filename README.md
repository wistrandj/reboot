# Init
    setxkbmap -layout fi -variant nodeadkeys
    setxkbmap -option 'caps:escape'
    mkdir -p $HOME/bin
    for f in dot/*; do
        b=$(basename "$f")
        ln -s "$(pwd)/dot/$b" "$HOME/.$b"
    done
    for f in bin/*; do
        b=$(basename "$f")
        ln -s "$(pwd)/bin/$b" "$HOME/bin/$b"
    done
    xmodmap $HOME/.Xmodmap

# Ansible 2.2 on debian
    echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" > "/etc/apt/sources.list.d/ansible.list"
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
    apt-get update
    apt-get install ansible

# Init-force
    ./init -dp Init | sed "s/ln -s/ln -fs/" | sh -v

# Hello
    for f in *; do
        echo ">>> $f"
    done

# Packages
    packages=(ncurses-dev git gitk xsel libx11-dev libxt-dev libgtk2.0-dev dbus-x11 python-dev)
    sudo apt-get install ${packages[@]}

# Vim
    git clone https://github.com/vim/vim
    cd vim
    ./configure --with-features=huge --enable-pythoninterp=dynamic --enable-gui=auto --with-x
    make
    sudo make install

# VimPlugins
    mkdir -p $HOME/.vim/bundle
    cd $HOME/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim
    git clone https://github.com/jasu0/VimBox-rc
    ln -s $HOME/.vim/bundle/VimBox-rc/vimrc $HOME/.vimrc
    vim +PluginInstall +q

# PgAdmin3
- Todo

# Java8

[Install Java 8](http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html)

    sudo vim /etc/apt/sources.list.d/java-8-debian.list
    deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
    sudo apt-get update
    sudo apt-get install oracle-java8-installer
    sudo apt-get install oracle-java8-set-default

# Docker

[Install docker](https://docs.docker.com/engine/installation/linux/debian/)
