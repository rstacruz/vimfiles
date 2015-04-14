# Install into home directory
link:
	ln -nfs "`pwd -LP`" ~/.vim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc

# Produce lockfile
lock:
	vim +"PlugSnapshot ./bin/install" +qa

# Upgrade plugins, vim-plug, and show changes
update:
	vim +PlugUpdate +PlugUpgrade +PlugDiff
upgrade: update

# Install from lockfile
install:
	./bin/install

.PHONY: install link update upgrade
