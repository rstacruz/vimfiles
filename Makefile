# Install into home directory
link:
	ln -nfs "`pwd -LP`" ~/.vim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc

# Produce lockfile
lock:
	vim +PlugInstall +"PlugSnapshot ./bin/install" +qa

# Upgrade plugins, vim-plug, and show changes
update:
	vim +PlugUpdate +PlugUpgrade +"PlugSnapshot ./bin/install" +PlugDiff
upgrade: update

# Install from lockfile
install:
	./bin/install

.PHONY: install link update upgrade
