local function get_default_mappings()
	local features = BaseConfig.features

	local mappings = {
		n = {
			["-"] = features.file_explorer and { "<cmd>NvimTreeFindFile<cr>", "Open file explorer" },
			["<c-p>"] = { "<cmd>lua require('core.actions').open_file_picker()<cr>", "Open file…" },
			["gs"] = { ":%s~~", "Replace with..." },
			["]g"] = features.gitsigns and { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Git change" },
			["[g"] = features.gitsigns and { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Previous Git change" }
					or nil,

			-- lsp
			["gd"] = features.lsp and { "<cmd>Telescope lsp_definitions<cr>", "Definitions (lsp)…" },
			["gr"] = features.lsp and { "<cmd>Telescope lsp_references<cr>", "References (lsp)…" },
			["gh"] = features.lsp and { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
			["gD"] = features.lsp and { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration (lsp)…" },
			["gi"] = features.lsp and { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation (lsp)…" },
			["K"] = features.lsp and { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },

			-- buffer
			["gb"] = { "<cmd>BufferLineCycleNext<cr>", "Buffer: next" },
			["gB"] = { "<cmd>BufferLineCyclePrev<cr>", "Buffer: previous" },
			["<tab>"] = { "<cmd>BufferLineCycleNext<cr>", "Buffer: next" },
			["<s-tab>"] = { "<cmd>BufferLineCyclePrev<cr>", "Buffer: previous" },

			-- Leader: [f] file
			["<leader>f"] = { name = "File…" },
			["<leader>fw"] = { "<cmd>noa w<cr>", " Save without formatting" },
			["<leader>fr"] = { "<cmd>e!<cr>", " Revert changes in file" },
			["<leader>fy"] = { [[:let @+=@% | echo '→ ' . @%<cr>]], " Copy current path" },
			["<leader>fY"] = { [[:let @+=expand('%:p') | echo '→ ' . expand('%:p')<cr>]], " Copy full path" },

			-- Leader: [g] git
			["<leader>g"] = features.github_fugitive and { name = "Git…" },
			["<leader>gb"] = features.github_fugitive and { "<cmd>Git blame<cr>", " Blame" },
			["<leader>gy"] = features.github_fugitive and { "<cmd>GBrowse!<cr>", " Copy GitHub URL" },
			["<leader>gY"] = features.github_fugitive and { "<cmd>GBrowse<cr>", " Open in GitHub" },

			-- Leader: [o] toggle
			["<leader>o"] = { name = "Toggle…" },
			["<leader>ow"] = { "<cmd>set wrap!<cr>", " Toggle word wrap" },
			["<leader>os"] = { "<cmd>set spell!<cr>", " Toggle Spell check" },
			["<leader>on"] = { "<cmd>set number!<cr>", " Toggle line numbers" },
			["<leader>or"] = { "<cmd>set relativenumber!<cr>", " Toggle relative line number" },
			["<leader>ob"] = {
				"<cmd>lua require('core.theme-utils').toggle_theme()<cr>",
				" Toggle light/dark theme",
			},
			-- ["<leader>oB"] = { "<cmd>lua vim.o.background = vim.o.background == 'light' and 'dark' or 'light'<cr>",
			-- "Toggle light/dark [B]ackground" },
			["<leader>oc"] = {
				"<cmd>lua vim.o.conceallevel = vim.o.conceallevel == 2 and 0 or 2<cr>",
				" Toggle conceal",
			},

			-- Leader: [od] diagnostic
			["<leader>od"] = features.lsp and { name = "Diagnostic…" },
			["<leader>odd"] = features.lsp and { "<cmd>lua vim.diagnostic.disable()<cr>", "[d]isable diagnostics" }
					or nil,
			["<leader>ode"] = features.lsp and { "<cmd>lua vim.diagnostic.enable()<cr>", "[e]nable diagnostics" }
					or nil,
			["<leader>odh"] = features.lsp and { "<cmd>lua vim.diagnostic.hide()<cr>", "[h]ide diagnostics" },
			["<leader>ods"] = features.lsp and { "<cmd>lua vim.diagnostic.show()<cr>", "[s]how diagnostics" },

			-- [s] settings
			["<leader>s"] = { name = "Settings…" },
			["<leader>s,"] = {
				"<cmd>vsplit " .. vim.fn.stdpath("config") .. "/init.lua<cr>",
				" Edit Neovim settings",
			},
			["<leader>s."] = {
				"<cmd>vsplit " .. vim.fn.stdpath("config") .. "/lua/custom/init.lua<cr>",
				" Edit custom settings",
			},
			["<leader>sc"] = { "<cmd>Telescope colorscheme<cr>", " Choose colorscheme…" },
			["<leader>sk"] = {
				"<cmd>vsplit " .. vim.fn.stdpath("config") .. "/lua/coresetup/keybindings.lua<cr>",
				" Edit keybindings",
			},
			["<leader>sr"] = {
				"<cmd>lua require('core.reload-utils').reload()<cr>",
				" Reload config",
			},
			["<leader>si"] = {
				"<cmd>lua require('core.reload-utils').reload()<cr>:PackerInstall<cr>",
				" Packer: Install new packages",
			},
			["<leader>su"] = {
				"<cmd>lua require('core.reload-utils').reload()<cr>:PackerSync<cr>",
				" Packer: Update packages",
			},

			-- Leader: [c] code
			["<leader>c"] = features.lsp and { name = "Code…" },
			["<leader>ca"] = features.lsp and { "<cmd>lua vim.lsp.buf.code_action()<cr>", " Actions…" },
			["<leader>cr"] = features.lsp and { "<cmd>lua vim.lsp.buf.rename()<cr>", " Rename symbol…" },
			["<leader>cd"] = features.lsp and { "<cmd>Telescope diagnostics<CR>", " Show diagnostics…" },
			["<leader>cf"] = features.lsp and {
				"<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>",
				" Format via LSP",
			},

			-- Leader: [b] buffers
			["<leader>b"] = { name = "Buffers…" },
			["<leader>bp"] = { "<cmd>BufferLinePick<cr>", " Pick…" },
			["<leader>b<space>"] = { "<cmd>BufferLineTogglePin<cr>", " Toggle pin" },
			["<leader>b."] = { "<cmd>BufferLineCloseRight<cr>", " Close to the right" },
			["<leader>b,"] = { "<cmd>BufferLineCloseLeft<cr>", " Close to the left" },
			["<leader>bo"] = {
				"<cmd>lua require('close_buffers').delete({ type = 'hidden' })<cr>",
				" Close other tabs",
			},
			["<leader>bO"] = {
				"<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true })<cr>",
				" Close other tabs (force)",
			},

			-- Leader: [x] exit
			["<leader>x"] = { name = "Exit…" },
			["<leader>xz"] = { "<cmd>cq<cr>", " Exit Neovim" },
			["<leader>xd"] = { "<cmd>bd!<cr>", " Destroy this buffer" },
			["<leader>xc"] = { "<cmd>bd!<cr>", " Close this buffer" },
			["<leader>xa"] = features.welcome_screen and { "<cmd>%bd! | Alpha<cr>", "  Close all" } or {
				"<cmd>%bd!<cr>",
				"  Close all",
			},

			-- [,] others
			["<leader>,"] = { name = "Experimental…" },
			["<leader>,s"] = { "<cmd>split ~/.scratchpad<cr><C-w>H", "Open [s]cratchpad" },
			["<leader>,p"] = { "<cmd>StartupTime --tries 12<cr>", "Profile startup time" },
		},
		nv = {
			["gl"] = features.hop and { "<cmd>HopLine<cr>", "Go to line" },
			["gw"] = features.hop and { "<cmd>HopWord<cr>", "Go to word" },
		},
		v = {
			["gs"] = { ":s~~", "Replace with..." },
		},
		ctrl = {
			["<c-h>"] = { [[<cmd>wincmd W | set winwidth=80 | set winwidth=20<cr>]], "Focus previous pane" },
			["<c-n>"] = { [[<cmd>wincmd w | set winwidth=80 | set winwidth=20<cr>]], "Focus next pane" },
			["<c-s>"] = { [[<cmd>w<cr><esc>]], "Save file" },
		},
	}
	return mappings
end

local function apply_mappings()
	local has, which_key = pcall(require, "which-key")
	if not has then
		return
	end

	local mappings = get_default_mappings()
	if not mappings then
		return
	end

	which_key.register(mappings.n, { mode = "n" })
	which_key.register(mappings.v, { mode = "v" })
	which_key.register(mappings.nv, { mode = "n" })
	which_key.register(mappings.nv, { mode = "v" })
	which_key.register(mappings.ctrl, { mode = "i" })
	which_key.register(mappings.ctrl, { mode = "t" })
	which_key.register(mappings.ctrl, { mode = "n" })
	which_key.register(mappings.ctrl, { mode = "v" })
end

local function setup()
	apply_mappings()
end

return { setup = setup, apply_mappings = apply_mappings }
