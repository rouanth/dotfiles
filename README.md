.files
======

A collection of configuration files for various utility programs.

Currently available are those:

   * .bashrc
   * .inputrc
   * .lynxrc
   * .muttrc
   * .nethackrc
   * .rtorrent.rc
   * .tmux.conf
   * .vimrc

Usage
-----

In order to install the templates, issue the command

    make install

If during the installation some files are to be overridden, the old ones are
preserved with prefix `.backup`.

Overriding the defaults
-----------------------

For some programs it's sensible to have special configurations on different
machines. Luckily, most of them support modularity of configuration files.

   * .bashrc loads .bashrc.local if it's present
   * .muttrc expects .muttrc.local
   * .tmux.conf expects .tmux.session.conf

