lockfile := ./bin/restore
vim := nvim

default: install

# Install into home directory
link: link-vim link-neovim

link-vim:
	ln -nfs "`pwd -LP`" ~/.vim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.vimrc

link-neovim:
	ln -nfs "`pwd -LP`" ~/.nvim
	ln -nfs "`pwd -LP`"/vimrc.vim ~/.nvimrc

# Installs plugins, produces lockfile
install:
	$(vim) +PlugInstall +PlugClean +"PlugSnapshot ${lockfile}" +qa

# Upgrade plugins, vim-plug, and show changes
update:
	$(vim) +PlugUpdate +PlugUpgrade +PlugClean +"PlugSnapshot ${lockfile}" +PlugDiff
upgrade: update

# Install from lockfile
restore:
	${lockfile}

.PHONY: install link update upgrade restore default link-vim link-neovim
