local function get_default_mappings()
	local mappings = {
		n = {
			["-"] = { "<cmd>NvimTreeFindFile<cr>", "Open file explorer" },
			["<c-p>"] = { "<cmd>Telescope find_files<cr>", "Open file…" },
			["gs"] = { ":%s~~", "Replace with..." },

			-- lsp
			["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Definitions (lsp)…" },
			["gr"] = { "<cmd>Telescope lsp_references<cr>", "References (lsp)…" },
			["gh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
			["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration (lsp)…" },
			["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation (lsp)…" },
			["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },

			-- buffer
			["gb"] = { "<cmd>BufferLineCycleNext<cr>", "Buffer: next" } or {},
			["gB"] = { "<cmd>BufferLineCyclePrev<cr>", "Buffer: previous" } or {},
			["<tab>"] = { "<cmd>BufferLineCycleNext<cr>", "Buffer: next" } or {},
			["<s-tab>"] = { "<cmd>BufferLineCyclePrev<cr>", "Buffer: previous" } or {},

			-- Leader: [f] file
			["<leader>f"] = { name = "[f]ile…" },
			["<leader>fw"] = { "<cmd>w<cr>", "Save file [w]" },
			["<leader>fs"] = { "<cmd>noa w<cr>", "[s]ave without formatting" },
			["<leader>fr"] = { "<cmd>e!<cr>", "[r]evert changes in file" },
			["<leader>fy"] = { [[:let @+=@% | echo '→ ' . @%<cr>]], "Cop[y] current path" },
			["<leader>fY"] = { [[:let @+=expand('%:p') | echo '→ ' . expand('%:p')<cr>]], "Cop[Y] full path" },

			-- Leader: [o] toggle
			["<leader>o"] = { name = "T[o]ggle…" },
			["<leader>ow"] = { "<cmd>set wrap!<cr>", "Toggle [w]ord wrap" },
			["<leader>os"] = { "<cmd>set spell!<cr>", "Toggle [s]pell check" },
			["<leader>on"] = { "<cmd>set number!<cr>", "Toggle line [n]umber" },
			["<leader>or"] = { "<cmd>set relativenumber!<cr>", "Toggle [r]elative line number" },
			["<leader>ob"] = { "<cmd>lua require('core.theme-utils').toggle_theme()<cr>", "Toggle light/dark theme" },
			-- ["<leader>oB"] = { "<cmd>lua vim.o.background = vim.o.background == 'light' and 'dark' or 'light'<cr>",
			-- "Toggle light/dark [B]ackground" },
			["<leader>oc"] = {
				"<cmd>lua vim.o.conceallevel = vim.o.conceallevel == 2 and 0 or 2<cr>",
				"Toggle [c]onceal",
			},

			-- Leader: [od] diagnostic
			["<leader>od"] = { name = "[d]iagnostic…" },
			["<leader>odd"] = { "<cmd>lua vim.diagnostic.disable()<cr>", "[d]isable diagnostics" },
			["<leader>ode"] = { "<cmd>lua vim.diagnostic.enable()<cr>", "[e]nable diagnostics" },
			["<leader>odh"] = { "<cmd>lua vim.diagnostic.hide()<cr>", "[h]ide diagnostics" },
			["<leader>ods"] = { "<cmd>lua vim.diagnostic.show()<cr>", "[s]how diagnostics" },

			-- [s] settings
			["<leader>s"] = { name = "[s]ettings…" },
			["<leader>s,"] = {
				"<cmd>vsplit " .. vim.fn.stdpath("config") .. "/init.lua<cr>",
				"Edit Neovim settings",
			},
			["<leader>sc"] = { "<cmd>Telescope colorscheme<cr>", "Choose [c]olorscheme…" },
			["<leader>sk"] = {
				"<cmd>vsplit " .. vim.fn.stdpath("config") .. "/lua/coresetup/keybindings.lua<cr>",
				"Edit [k]eybindings",
			},
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

			-- Leader: [c] code
			["<leader>c"] = { name = "[c]ode…" },
			["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "[a]ctions…" },
			["<leader>cr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[r]ename symbol…" },
			["<leader>cd"] = { "<cmd>Telescope diagnostics<CR>", "Show [d]iagnostics" },
			["<leader>cf"] = { "<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>", "[f]ormat via LSP" },

			-- Leader: [b] buffers
			["<leader>b"] = { name = "[b]uffers…" },
			["<leader>bp"] = { "<cmd>BufferLinePick<cr>", "[p]ick…" },
			["<leader>b<space>"] = { "<cmd>BufferLineTogglePin<cr>", "Toggle [P]in" },
			["<leader>b."] = { "<cmd>BufferLineCloseRight<cr>", "Close to the right" },
			["<leader>b,"] = { "<cmd>BufferLineCloseLeft<cr>", "Close to the left" },
			["<leader>bo"] = {
				"<cmd>lua require('close_buffers').delete({ type = 'hidden' })<cr>",
				"Close [o]ther tabs",
			},
			["<leader>bO"] = {
				"<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true })<cr>",
				"Close [O]ther tabs (force)",
			},

			-- Leader: [x] exit
			["<leader>x"] = { name = "E[x]it…" },
			["<leader>xz"] = { "<cmd>cq<cr>", "Exit Neovim [z]" },
			["<leader>xd"] = { "<cmd>bd!<cr>", "[d]estroy this buffer" },
			-- ["<leader>xa"] = { "<cmd>%bd! | Alpha<cr>", "Back to st[a]rt screen" },

			-- [,] others
			["<leader>,"] = { name = "experimental…" },
			["<leader>,s"] = { "<cmd>split ~/.scratchpad<cr><C-w>H", "Open [s]cratchpad" },
			["<leader>,p"] = { "<cmd>StartupTime --tries 12<cr>", "Profile startup time" },
		},
		nv = {
			["gl"] = { "<cmd>HopLine<cr>", "Go to line" },
			["gw"] = { "<cmd>HopWord<cr>", "Go to word" },
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
	local which_key = require("which-key")

	local mappings = get_default_mappings()
	if not mappings then
		return
	end

	which_key.register(mappings.n or {}, { mode = "n" })
	which_key.register(mappings.v or {}, { mode = "v" })
	which_key.register(mappings.nv or {}, { mode = "n" })
	which_key.register(mappings.nv or {}, { mode = "v" })
	which_key.register(mappings.ctrl or {}, { mode = "i" })
	which_key.register(mappings.ctrl or {}, { mode = "t" })
	which_key.register(mappings.ctrl or {}, { mode = "n" })
	which_key.register(mappings.ctrl or {}, { mode = "v" })
end

local function setup()
	apply_mappings()
end

return { setup = setup, apply_mappings = apply_mappings }
