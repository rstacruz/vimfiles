lockfile := ./bin/restore

# Install into home directory
link:
	ln -nfs "`pwd -LP`" ~/.vim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc

# Installs plugins, produces lockfile
install:
	vim +PlugInstall +"PlugSnapshot ${lockfile}" +qa

# Upgrade plugins, vim-plug, and show changes
update:
	vim +PlugUpdate +PlugUpgrade +"PlugSnapshot ${lockfile}" +PlugDiff
upgrade: update

# Install from lockfile
restore:
	${lockfile}

.PHONY: install link update upgrade restore
