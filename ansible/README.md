
## Usage

Parameters:

- *-e window_manager=mate* - install mate window manager. Check these in ./roles/x11-lightdm/defaults/main.yml
- *-e lightdm_autologin=vagrant* - login automatically when window manager is enabled
- *-e compile_vim=true* - compile and install vim
- *-e vim_users=vagrant* - install vim plugins for vagrant user

## Compiling python into vim

Currently the vim role doesn't compile vim with  python or python3
support. You can do it manually after running this playbook by running 

    $ cd /tmp/vim
    $ ./configure --prefix=/usr/local/ --enable-python3interp

and editing the file `./src/Makefile` by uncommenting either of the
lines

    CONF_OPT_PYTHON = --enable-pythoninterp
    CONF_OPT_PYTHON3 = --enable-python3interp
