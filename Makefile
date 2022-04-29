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

snapshot: ## Take snapshot of known working package versions (experimental)
	rm -f ~/.cache/nvim/packer.nvim/packer.lock
	nvim "+autocmd User PackerComplete qa!" "+PackerSnapshot packer.lock"
	cp ~/.cache/nvim/packer.nvim/packer.lock .

rollback: ## Rollback to last snapshot (experimental)
	cp packer.lock ~/.cache/nvim/packer.nvim/packer.lock
	nvim "+autocmd User PackerComplete qa!" "+PackerSnapshotRollback packer.lock"

fmt:
	stylua lua/ init.lua
