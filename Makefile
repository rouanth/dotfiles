LOCAL_FILES = 

DOTFILES = \
	XCompose \
	bashrc \
	ncmpcpp \
	lynxrc \
	muttrc \
	nethackrc \
	rtorrent.rc \
	tmux.conf \
	vimrc \
	inputrc \
	config/newsbeuter/config \
	config/tox/toxic.conf \
	config/i3/config \
	vimperatorrc \
	config/user-dirs.dirs \
	config/kak/kakrc \
	config/kak-lsp/kak-lsp.toml \
	Xdefaults \
	$(LOCAL_FILES)

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

