PACKER_PATH = $(HOME)/.local/share/nvim/site/pack/packer/start/packer.nvim

install: packer

packer: $(PACKER_PATH) ## Install packer
$(PACKER_PATH):
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $(PACKER_PATH)

sync: packer
	nvim +PackerCompile +PackerSync

clean: ## Removes packer
	rm -rf $(PACKER_PATH) plugin/packer_compiled.lua

clean-all: ## Removes packer and all plugins
	rm -rf $(HOME)/.local/share/nvim/site/pack/packer plugin/packer_compiled.lua

fmt:
	stylua lua/ init.lua
