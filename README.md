.files
======

A collection of configuration files for various utility programs.

Currently available are the templates:

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

Overriding the defaults
-----------------------

To use the repository without modification and still have some specific parts
of configuration added, the user should create `.dotfile_templates` and add
files with suffix `.pre` or `.post` and the names corresponding to those in
the repository. And example of such file is
`$HOME/.dotfile_templates/bashrc.post`
