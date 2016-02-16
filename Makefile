DOTFILES=bashrc lynxrc muttrc nethackrc rtorrent.rc tmux.conf vimrc inputrc

PERSONAL_DOTFILES=$(addprefix ${HOME}/., $(DOTFILES))
TEMPL_DIR=${HOME}/.dotfile_templates/

install: $(PERSONAL_DOTFILES)

${HOME}/.% : %
	if [ -e "$@" ]; then mv -f $@ $@.backup; fi
	for file in "$(TEMPL_DIR)$<.pre" "$<" "$(TEMPL_DIR)$<.post"; do \
	        if [ -e "$$file" ]; then cat $$file >> $@; fi; done

.PHONY: install clean
