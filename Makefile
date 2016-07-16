DOTFILES = bashrc lynxrc muttrc nethackrc rtorrent.rc tmux.conf vimrc inputrc
DIR = $(DESTDIR)${HOME}

INSTALLED_FILES = $(addprefix $(DIR)/., $(DOTFILES))
BACKUPS = $(addsuffix .backup, $(INSTALLED_FILES))

install: $(INSTALLED_FILES)

$(addprefix $(DIR)/., tmux.local.conf muttrc.local) :
	touch $@

$(DIR)/.% : %
	@ if [ -e '$@' ] && ! diff -q '$@' '$^' > /dev/null; then \
	     	mv -v $@ $@.backup; fi
	@ mkdir -p `dirname $@`
	@ ln -vsf '$(CURDIR)/$^' '$@'

.PHONY: install clean

