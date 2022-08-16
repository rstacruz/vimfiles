local function setup()
	local has, nvim_tree = pcall(require, "nvim-tree")
	if not has then
		return
	end

	nvim_tree.setup({
		sync_root_with_cwd = true,
		view = {
			width = 30,
		},
		renderer = {
			add_trailing = false,
			special_files = {
				"Cargo.toml",
				"Makefile",
				-- git
				".git",
				".gitignore",
				".gitattributes",
				".gitmodules",
				-- docs
				"README.md",
				-- js
				"package.json",
				"package-lock.json",
				"yarn.lock",
				".babelrc",
				".babel.config.js",
				".babel.config.cjs",
				".babel.config.mjs",
				".prettierrc",
				".prettierignore",
				".npmrc",
				".npmignore",
				"postcss.config.js",
				"tailwind.config.js",
				"tsconfig.json",
				"jsconfig.json",
				-- Docker
				".dockerignore",
				-- lua
				".luarc.json",
				"packer.lock",
				"stylua.toml",
				-- special
				".vscode",
				".obsidian",
				".stignore",
			},
			indent_markers = {
				enable = true,
			},
		},
	})
end

return { setup = setup }
