Reboot
======


How to's
========

### How can I setup graphical environment for Debian?

Install *lightdm* which also installs all needed X11 packages. Some common desktop environment has to be installed separately:

- mate-session-manager - basic setup, needs also *mate-terminal* installed (150Mb)
- mate-desktop-environments - this seems to be overkill (900Mb)

When you have installed many desktop environments, you can control which one gets loaded by running

    update-alternatives --config x-session-manager

The window manager can also be changed by running

    update-alternatives --config x-window-manager

Debian has these *alternatives* packages which tells the default piece of software for each tasks. It works by having a tag (such as *x-session-manager* and *x-window-manager*) and having symlinks in `/etc/alternatives/` to default programs.

It might be possible to set session-managers in Lightdm configuration in `/etc/lightdm/ligthdm.conf` but it seems to follow alternatives by default. Somebody said it reads *desktop* files in `/usr/share/xsession` and runs one from there.

New session and window managers can by found by issuing

     apt-cache search x-session-manager

and

     apt-cache search x-window-manager

*Open questions*

- How can we set user-specific session-manager?
- When are scripts `$HOME/.xinitrc` and `$HOME/.xsessions` run?
    * I'd like to set setxkbmap
- Setup guest account in Lightdm

*Miscellaneous*

- Lightdm password selection screen can be changed. It has *alternatives* tag *ligthdm-greeter*

- setup autologin in `/etc/lightdm/lightdm.conf`:

    [Seat:*]
    autologin-user = vagrant

- show user list in Lightdm

    [LightDM]
    greeter-show-manual-login=true
    [Seat:*]
    greeter-hide-users = false

- Don't ask password in Lightdm

    sudo passwd -d $(whoami)

### How to set finnish keyboard layout?

Install *keyboard-configuration* and *console-setup*. Then run

    dpkg-reconfigure keyboard-configuration

and set whatever setup you want. Check `/etc/default/keyboard` that it has correct setup. That's it?
