local function get_default_mappings()
	local mappings = {
		default = {
			n = {
				["-"] = { "<cmd>NvimTreeFindFile<cr>", "Open file explorer" },
				["<c-p>"] = { "<cmd>Telescope find_files<cr>", "Open file…" },

				["<leader>s"] = { name = "[s]ettings…" },
				["<leader>s,"] = { "<cmd>vsplit " .. vim.fn.stdpath("config") .. "/init.lua<cr>", "Edit Neovim settings" },
				["<leader>sc"] = { "<cmd>Telescope colorscheme<cr>", "Choose [c]olorscheme…" },
				["<leader>sk"] = { "<cmd>vsplit " .. vim.fn.stdpath("config") .. "/lua/coresccup/keybindings.lua<cr>", "Edit [k]eybindings" },
				["<leader>sr"] = {
					"<cmd>lua require('core.utils').reload()<cr>",
					"Reload config",
				},
				["<leader>si"] = {
					"<cmd>lua require('core.utils').reload()<cr>:PackerInstall<cr>",
					"Packer: [i]nstall new packages",
				},
				["<leader>su"] = {
					"<cmd>lua require('core.utils').reload()<cr>:PackerSync<cr>",
					"Packer: [u]pdate packages",
				},

				["<leader>,"] = { name = "experimental…" },
				["<leader>,p"] = { "<cmd>StartupTime --tries 12<cr>", "Profile startup time" },
			},
			v = {},
			ctrl = {
				["<c-h>"] = { [[<cmd>wincmd W | set winwidth=80 | set winwidth=20<cr>]], "Focus previous pane" },
				["<c-n>"] = { [[<cmd>wincmd w | set winwidth=80 | set winwidth=20<cr>]], "Focus next pane" },
				["<c-s>"] = { [[<cmd>w<cr><esc>]], "Save file" },
			},
		},
	}
	return mappings
end

local function apply_mappings(key)
  local which_key = require("which-key")

	local mappings = get_default_mappings()[key]
	if not mappings then
		return
	end

	which_key.register(mappings.n, { mode = "n" })
	which_key.register(mappings.v, { mode = "v" })
	which_key.register(mappings.ctrl, { mode = "i" })
	which_key.register(mappings.ctrl, { mode = "t" })
	which_key.register(mappings.ctrl, { mode = "n" })
	which_key.register(mappings.ctrl, { mode = "v" })
end

local function setup()
	apply_mappings("default")
end

return { setup = setup, apply_mappings = apply_mappings }
