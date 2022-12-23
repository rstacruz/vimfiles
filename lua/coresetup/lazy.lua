local function setup(packages)
	local options = {
		defaults = { lazy = true },
		performance = {
			rtp = {
				disabled_plugins = {
					-- "gzip",
					-- "matchit",
					-- "matchparen",
					-- "netrwPlugin",
					-- "tarPlugin",
					-- "tohtml",
					-- "tutor",
					-- "zipPlugin",
					"2html_plugin",
					"bugreport",
					"compiler",
					"ftplugin",
					"getscript",
					"getscriptPlugin",
					"gzip",
					"logipat",
					"matchit",
					"matchparen",
					"netrwFileHandlers",
					"netrwPlugin",
					"netrwSettings",
					"optwin",
					"rplugin",
					"rrhelper",
					"spellfile_plugin",
					"synmenu",
					"syntax",
					"tar",
					"tarPlugin",
					"tohtml",
					"tutor",
					"vimball",
					"vimballPlugin",
					"zip",
					"zipPlugin",
					"node_provider",
					"perl_provider",
					"python3_provider",
					"ruby_provider",
				},
			},
		},
	}
	require("lazy").setup(packages, options)
end

return { setup = setup }
