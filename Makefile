lockfile := ./bin/restore
vim := nvim
pwd := $(shell pwd -LP)

default:
	@echo
	@echo "Makefile targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-20s\033[0m %s\n", $$1, $$2}'
	@echo

# Update documentation
doc: doc/vimfiles_keys.txt
docs:
	@echo "Try: 'make doc'"

doc/vimfiles_keys.txt:
	mkdir -p doc
	bash _tools/help.sh > $@

help: ## Print key bindings
	@bash _tools/help.sh

link: link-vim link-neovim ## Link cwd to ~/.vim and ~/.config/nvim
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

install: ## Runs :PlugInstall (installs plugins & make lockfile) [alias: i]
	$(vim) +PlugInstall +PlugClean +"PlugSnapshot ${lockfile}" +qa

upgrade: ## Runs :PlugUpdate (updates plugins) [alias: u]
	$(vim) +PlugUpdate +PlugUpgrade +PlugClean +"PlugSnapshot ${lockfile}" +PlugDiff

restore: ## Install from lockfile
	$(vim) -S ${lockfile}

i: install
u: upgrade

.PHONY: install link upgrade restore default link-vim link-neovim doc/vimfiles_keys.txt
