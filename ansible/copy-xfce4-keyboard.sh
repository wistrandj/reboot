#!/bin/bash

path="xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"

if [[ ! -f $HOME/.config/$path ]]; then
    echo "xfce4 config file doesn't exist"
fi

if [[ ! -f ./roles/users/files/home/user/config/$path ]]; then
    echo "ansible config file doesn't exists"
fi

cp $HOME/.config/$path ./roles/users/files/home/user/config/$path
