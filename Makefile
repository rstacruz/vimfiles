lockfile := ./bin/restore
vim := vim
pwd := $(shell pwd -LP)

default: install

help:
	@bash _tools/help.sh

# Install into home directory
link: link-vim link-neovim
	@if [ ! -d ~/.vim/vendor ]; then \
		echo "\n\033[32;1m→ NOTE:\033[0m run ':PlugInstall' in Vim to install plugins."; \
		echo "  (alternatively, use 'make install')"; \
	fi

link-vim:
	@echo "==> ~/.vim"
	@if [ ! . -ef ~/.vim ]; then ln -nfs "${pwd}" ~/.vim; fi
	@echo "==> ~/.vimrc"
	@ln -nfs "${pwd}/init.vim" ~/.vimrc

link-neovim:
	@mkdir -p ~/.config
	@echo "==> ~/.config/nvim"
	@if [ ! . -ef ~/.config/nvim ]; then ln -nfs "${pwd}" ~/.config/nvim; fi

# Installs plugins, produces lockfile
install:
	$(vim) +PlugInstall +PlugClean +"PlugSnapshot ${lockfile}" +qa

# Updates plugins, vim-plug, and show changes
upgrade:
	$(vim) +PlugUpdate +PlugUpgrade +PlugClean +"PlugSnapshot ${lockfile}" +PlugDiff

# Install from lockfile
restore:
	$(vim) -S ${lockfile}

.PHONY: install link upgrade restore default link-vim link-neovim
