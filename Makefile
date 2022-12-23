# Run 'make nvim' to test out nvim with nvim-starter configuration.
# This allows testing it out without affecting your existing neovim config.

playground_path = $(shell pwd)/.neovim_playground_env
playground_config_path = $(playground_path)/.config
playground_data_path = $(playground_path)/data
env = XDG_CONFIG_HOME="$(playground_config_path)" XDG_DATA_HOME="$(playground_data_path)"

format:
	stylua init.lua lua/**/*.lua

nvim: setup # Launch neovim with this config
	$(env) nvim

fish: setup ## Sets up fish abbreviation for launching with this config
	fish -c 'abbr nvim-nm "$(env) nvim"'
	@echo "Type 'nvim-nm' to open in this config"

setup:
	@mkdir -p "$(playground_config_path)"
	@mkdir -p "$(playground_data_path)"
	@ln -nfs "$(shell pwd)" "$(playground_config_path)/nvim"

clean: ## Clean the data dir
	rm -rf "$(playground_path)"

docker:
	docker run \
		-w /root/.config/nvim \
		-v $(shell pwd):/root/.config/nvim \
		--name neovim-nimble-01 \
		alpine:edge sh -uelic ' \
	  apk add git nodejs neovim ripgrep --update; true' || true
	docker start neovim-nimble-01
	docker exec -it neovim-nimble-01 nvim

docker-clean:
	docker rm -f neovim-nimble-01
