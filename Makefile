# Run 'make nvim' to test out nvim with nvim-starter configuration.
# This allows testing it out without affecting your existing neovim config.

playground_path = $(shell pwd)/.neovim_playground_env
playground_config_path = $(playground_path)/.config
playground_data_path = $(playground_path)/data
env = XDG_CONFIG_HOME="$(playground_config_path)" XDG_DATA_HOME="$(playground_data_path)"

nvim: setup # Launch neovim with this config
	$(env) nvim

fish: setup ## Sets up fish abbreviation for launching with this config
	fish -c 'abbr nvim-rsc "$(env) nvim"'
	@echo "Type 'nvim-rsc' to open in this config"

setup:
	@mkdir -p "$(playground_config_path)"
	@mkdir -p "$(playground_data_path)"
	@ln -nfs "$(shell pwd)" "$(playground_config_path)/nvim"

clean: ## Clean the data dir
	rm -rf "$(playground_path)"
