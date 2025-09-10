local function setup_mini()
	local path_package = vim.fn.stdpath("data") .. "/site/"
	local mini_path = path_package .. "pack/deps/start/mini.nvim"
	if not vim.loop.fs_stat(mini_path) then
		vim.cmd('echo "Installing `mini.nvim`" | redraw')
		local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/nvim-mini/mini.nvim", mini_path }
		vim.fn.system(clone_cmd)
		vim.cmd("packadd mini.nvim | helptags ALL")
		vim.cmd('echo "Installed `mini.nvim`" | redraw')
	end
	require("mini.deps").setup({ path = { package = path_package } })
	require("mini.basics").setup()
end

setup_mini()
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- Convenient config for all things related to language setup (LSP, etc)
local LANG_CONFIG = {
	treesitter = { "lua", "vimdoc", "javascript", "markdown" },
	mason = { "lua-language-server", "prettierd" },
	-- tools
	lsp = { "vtsls" },
	linters_by_ft = {
		lua = {},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "prettierd" },
		fish = { "fish_indent" },
		sh = { "shfmt" },
	},
}

-- Termux: some tools are only available certain platforms
local is_termux = string.find(vim.loop.os_uname().release, "android")
if not is_termux then
	table.insert(LANG_CONFIG.lsp, "lua_ls")
end

now(function() -- options
	vim.opt.laststatus = 0 -- to be set later
	vim.opt.tabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.foldlevel = 99
	vim.opt.updatetime = 500 -- time to show diagnostics
	vim.opt.winborder = "rounded" -- for lsp popups
	vim.opt.fillchars = {
		foldopen = "",
		foldclose = "",
		fold = " ",
		foldsep = " ",
		diff = "╱",
		eob = " ",
	}

	if vim.fn.has("nvim-0.10") == 1 then
		vim.opt.smoothscroll = true
		vim.opt.foldexpr = "v:lua.require'mylib.fold'.foldexpr()"
		vim.opt.foldmethod = "expr"
		vim.opt.foldtext = ""
	else
		vim.opt.foldmethod = "indent"
		vim.opt.foldtext = "v:lua.require'mylib.fold'.foldtext()"
	end
end)

now_if_args(function() -- tree sitter
	add({
		source = "nvim-treesitter/nvim-treesitter",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})

	require("nvim-treesitter.configs").setup({
		ensure_installed = LANG_CONFIG.treesitter,
		indent = { enable = true },
		highlight = { enable = true },
	})
end)

now(function() -- color scheme
	add({ source = "rebelot/kanagawa.nvim" })
	add({ source = "projekt0n/github-nvim-theme" })
	require("mylib.persist_colorscheme").setup({ fallback = "miniautumn" })
end)

now(function() -- snacks: indent guides
	add({ source = "folke/snacks.nvim" })
	vim.g.snacks_animate = false
	require("snacks").setup({
		indent = { enabled = true }, -- needs early setup
	})
end)

now(function() -- autocmd's
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("custom_markdown", { clear = true }),
		pattern = { "markdown" },
		callback = function()
			vim.opt_local.cursorline = false -- doesn't look good with headlines
			vim.opt_local.spell = false -- I find spellcheck only useful when writing prose. toggle with leader-us
			vim.opt_local.wrap = false -- inline links make wrapping very weird. toggle with leader-uw
			vim.opt_local.relativenumber = false
			vim.opt_local.number = false -- toggle with leader-ul
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("custom_yaml", { clear = true }),
		pattern = { "yaml" },
		callback = function()
			-- idk why this is not set
			vim.defer_fn(function()
				vim.opt_local.fixeol = true
			end, 0)
		end,
	})
end)

later(function() -- editor: lsp features (blink, mason, lspconfig)
	add({ source = "Saghen/blink.cmp", checkout = "v1.6.0" })
	add({ source = "mason-org/mason.nvim" })
	add({
		source = "neovim/nvim-lspconfig",
		depends = { "mason-org/mason.nvim", "saghen/blink.cmp" },
	})
	add({
		source = "mason-org/mason-lspconfig.nvim",
		depends = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
	})
	require("mason").setup({})
	-- require("mason-lspconfig").setup({ ensure_installed = vim.tbl_extend("force", LANG_CONFIG.lsp, LANG_CONFIG.mason) })
	require("mason-lspconfig").setup({ ensure_installed = LANG_CONFIG.lsp })

	-- Automatically pop up after `updatetime` milliseconds
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			vim.diagnostic.open_float(nil, { focus = false })
		end,
	})

	-- https://github.com/mason-org/mason.nvim?tab=readme-ov-file#configuration
	-- https://neovim.io/doc/user/lsp.html#lsp-quickstart
	-- https://github.com/neovim/nvim-lspconfig
	-- https://www.lazyvim.org/extras/coding/blink
end)

later(function() -- editor: linting
	add({
		source = "mfussenegger/nvim-lint",
	})
	require("lint").linters_by_ft = LANG_CONFIG.linters_by_ft
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
end)

later(function() -- editor: formatting
	add({ source = "stevearc/conform.nvim" })
	require("conform").setup({ formatters_by_ft = LANG_CONFIG.formatters_by_ft })

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>cf", function() require("conform").format() end, { desc = "Format" })
	-- stylua: ignore end

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = function(args)
			require("conform").format({ bufnr = args.buf })
		end,
	})

	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#setup
	-- https://www.lazyvim.org/plugins/formatting
end)

later(function() -- keys, keymaps
	local function copy_path(opts)
		local str = vim.fn.expand(opts.expand)
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")
		if opts and opts.range then
			if start_line == end_line then
				str = str .. "#L" .. start_line
			else
				str = str .. "#L" .. start_line .. "-" .. end_line
			end
		end
		vim.fn.setreg('"', str)
		vim.fn.setreg("+", str)
		vim.notify(" " .. str)
	end

	local function copy_absolute_path()
		return copy_path({ expand = "%:p" })
	end
	local function copy_absolute_path_range()
		return copy_path({ expand = "%:p", range = 1 })
	end
	local function copy_relative_path()
		return copy_path({ expand = "%:." })
	end
	local function copy_relative_path_range()
		return copy_path({ expand = "%:.", range = 1 })
	end

	-- System clipboard
	vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
	vim.keymap.set("i", "<C-S-v>", "<C-R>+", { desc = "Paste from clipboard" })

	-- Windows
	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

	-- Make `23,` go to line 23. Easier to type than `23G`
	vim.keymap.set("n", ",", "G", { desc = "Go to line" })
	vim.keymap.set("v", ",", "G", { desc = "Go to line" })

  -- stylua: ignore start
	vim.keymap.set("n", "<c-p>", function() Snacks.picker.files() end, { desc = "Open file..." })
	vim.keymap.set("n", "<F1>", function() Snacks.picker.keymaps() end, { desc = "Open keymaps" })
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
	vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, { desc = "Show implementation" })
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { desc = "Show references" })
	vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, { desc = "Go to type definition" })
	vim.keymap.set("n", "g.", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
	vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Close all and exit" })
	vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Search in files via grep..." })
	vim.keymap.set("n", "<leader>e", function() Snacks.picker.explorer() end, { desc = "Open file browser (sidebar)" })
	vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Switch buffer" })
	vim.keymap.set("n", "<leader>fya", function() copy_absolute_path() end, { desc = " Copy absolute path" })
	vim.keymap.set("n", "<leader>fyr", function() copy_relative_path() end, { desc = " Copy relative path" })
	vim.keymap.set("n", "<leader>!s", "<cmd>split ~/.scratchpad.md<cr><C-w>H", { desc = "Open scratchpad" })
	vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Change colorscheme" })
	vim.keymap.set("n", "<leader>ux", function() Snacks.picker() end, { desc = "Choose picker" })
	vim.keymap.set("n", "<leader>u,", function() vim.cmd("e ~/.config/nvim/init.lua") end, { desc = "Open settings" })
  vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
	vim.keymap.set("v", "<leader>fya", function() copy_absolute_path_range() end, { desc = " Copy absolute path with line numbers" })
	vim.keymap.set("v", "<leader>fyr", function() copy_relative_path_range() end, { desc = " Copy relative path with line numbers" })
	vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Open keymaps" })
	-- stylua: ignore end
end)

later(function() -- mini.clue: shows keyboard shortcuts
	local miniclue = require("mini.clue")
	miniclue.setup({
		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },
			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },
			-- `g` key
			{ mode = "n", keys = "g" },
			{ mode = "x", keys = "g" },
			-- Marks
			{ mode = "n", keys = "'" },
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },
			-- Registers
			{ mode = "n", keys = '"' },
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },
			-- Window commands
			{ mode = "n", keys = "<C-w>" },
			-- `z` key
			{ mode = "n", keys = "z" },
			{ mode = "x", keys = "z" },
		},
		window = {
			delay = 150,
			config = { width = 30 },
		},

		clues = {
			{ mode = "n", keys = "<leader>u", desc = "+settings" },
			{ mode = "n", keys = "<leader>s", desc = "+search" },
			{ mode = "n", keys = "<leader>c", desc = "+code" },
			{ mode = "n", keys = "<leader>x", desc = "+diagnostics" },
			{ mode = "n", keys = "<leader>f", desc = "+file" },
			{ mode = "n", keys = "<leader>q", desc = "+quit" },
			-- Enhance this by adding descriptions for <Leader> mapping groups
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
		},
	})
end)

later(function() -- mini.notify: toast notifications
	local notify = require("mini.notify")
	notify.setup({})
	vim.notify = notify.make_notify({})

	vim.keymap.set("n", "<leader>snh", function()
		notify.show_history()
	end, { desc = "Show notification history" })

	-- https://github.com/nvim-mini/mini.notify
end)

later(function() -- mylib.autosize: resize window widths
	require("mylib.autosize").setup()
end)

later(function() -- trouble: diagnostics
	add({ source = "folke/trouble.nvim" })
	require("trouble").setup({})

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>xx", function() vim.cmd("Trouble diagnostics toggle") end, { desc = "Show diagnostics" })
	-- stylua: ignore end
end)

later(function() -- render-markdown
	add({ source = "MeanderingProgrammer/render-markdown.nvim" })
	require("render-markdown").setup({
		render_modes = { "n", "v", "i", "c" },
		heading = {
			icons = { "━ " },
			signs = { "󰎤 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " },
		},

		code = {
			sign = false,
			style = "normal",
			width = "block",
			position = "right",
			right_pad = 5,
			border = "thick",
		},

		bullet = {
			enabled = true,
			icons = { "─", "─", "─", "─" }, -- default: { '●', '○', '◆', '◇' },
			highlight = "DiagnosticInfo", -- 'RenderMarkdownBullet',
		},

		checkbox = {
			unchecked = { icon = "□" },
			checked = { icon = "󰸞", highlight = "DiagnosticOk" }, -- nf-md-check-bold
			custom = {
				wait = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo" },
				prio = { raw = "[!]", rendered = "󰄰", highlight = "DiagnosticError" }, -- high priority
				done = { raw = "[x]", rendered = "󰸞", highlight = "DiagnosticOk" },
				fwd = { raw = "[>]", rendered = "󰒊", highlight = "Comment" }, -- nf-md-send
				sched = { raw = "[<]", rendered = "󰃰", highlight = "Comment" }, -- nf-md-calendar_clock
				cancel = { raw = "[~]", rendered = "󰏤", highlight = "DiagnosticWarn" },
				info = { raw = "[i]", rendered = "󰋼", highlight = "DiagnosticInfo" }, -- nf-md-information -- `i` in obsidian
				idea = { raw = "[l]", rendered = "󰌵", highlight = "DiagnosticWarn" }, -- nf-md-lightbulb -- `I` in obsidian
				pro = { raw = "[p]", rendered = "󰔓", highlight = "DiagnosticOk" }, -- nf-md-thumb_up
				con = { raw = "[c]", rendered = "󰔑", highlight = "DiagnosticError" }, -- nf-md-thumb_down
				star = { raw = "[s]", rendered = "󰓎", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
				star2 = { raw = "[*]", rendered = "󰓎", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
				bookmark = { raw = "[b]", rendered = "󰃀", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
				half = { raw = "[/]", rendered = "󰿦", highlight = "Comment" }, -- in progress, nf-md-texture_box
			},
		},

		callout = {
			highlights = { raw = "[!HIGHLIGHTS]", rendered = "󰌶 Highlights ", highlight = "RenderMarkdownHint" },
			tldr = { raw = "[!TLDR]", rendered = "󰌶 TLDR ", highlight = "RenderMarkdownHint" },
			summary = { raw = "[!SUMMARY]", rendered = "󰌶 Summary ", highlight = "RenderMarkdownHint" },
		},

		link = {
			-- Fallback icon for 'inline_link' elements
			-- hyperlink = "󰌹 ",
			hyperlink = "",

			-- image = "󰥶 ", -- Inlined with 'image' elements
			-- email = "󰀓 ", -- Inlined with 'email_autolink' elements
			-- hyperlink = "󰌹 ", -- Fallback icon for 'inline_link' elements
			-- wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
			wiki = { icon = "", highlight = "RenderMarkdownLink" },

			custom = {
            -- web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
            -- stylua: ignore start
            jira = { pattern = "^http[s]?://%a+.atlassian.net/browse", icon = "󰌃 ", highlight = "RenderMarkdownLink" },
            conf = { pattern = "^http[s]?://%a+.atlassian.net/wiki", icon = " ", highlight = "RenderMarkdownLink" }, -- nf-fa-confluence
            slack = { pattern = "^http[s]?://%a+.slack.com", icon = "󰒱 ", highlight = "RenderMarkdownLink" }, -- nf-md-slack
            github = { pattern = "^http[s]?://github.com", icon = "󰊤 ", highlight = "RenderMarkdownLink" }, -- nf-md-github + ctrl-k 1M
            gitlab = { pattern = "^http[s]?://gitlab.com", icon = " ", highlight = "RenderMarkdownLink" }, -- nf-fa-gitlab
            trello = { pattern = "^http[s]?://trello.com", icon = "󰔲 ", highlight = "RenderMarkdownLink" },
            miro = { pattern = "^http[s]?://miro.com", icon = "󰃥 ", highlight = "RenderMarkdownLink" },
            datadog = { pattern = "^http[s]?://app.datadoghq.com", icon = "󰩃 ", highlight = "RenderMarkdownLink" },
            googledrive = { pattern = "^http[s]?://drive.google.com", icon = "󰊶 ", highlight = "RenderMarkdownLink", },
            web = { pattern = "^http[s]?://", icon = "󰏌 ", highlight = "RenderMarkdownLink" }, -- nf-md-open_in_new + ctrl-k 1M
				-- stylua: ignore end
			},
		},
	})
end)

later(function() -- mini.statusline
	local statusline = require("mini.statusline")

	local function active()
		local mode, mode_hl = statusline.section_mode({ trunc_width = 2000 })
		local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
		local lsp = statusline.section_lsp({ trunc_width = 75 })
		local filename = statusline.section_filename({ trunc_width = 12 })
		local search = statusline.section_searchcount({ trunc_width = 75 })

		return statusline.combine_groups({
			{ hl = mode_hl, strings = { mode } },
			"%<", -- Mark general truncate point
			{ hl = "MiniStatuslineFilename", strings = { filename } },
			"%=", -- End left alignment
			{ hl = "MiniStatuslineInactive", strings = { diagnostics, lsp } },
			{ hl = "MiniStatuslineFileinfo", strings = { search } },
			{ hl = "MiniStatuslineInactive", strings = { "%2l:%-2v" } },
			{ hl = mode_hl, strings = { " " } },
		})
	end
	statusline.setup({ content = { active = active } })

	-- Restore status line that was hidden earlier
	vim.opt.laststatus = 2
end)

later(function() -- mini.files
	local MiniFiles = require("mini.files")
	MiniFiles.setup({
		mappings = {
			go_in_plus = "<cr>",
			synchronize = "<c-s>",
		},
		windows = {
			max_number = 3,
			preview = true,
			width_nofocus = math.floor((vim.o.columns - 5) * 0.25), -- 25% of screen minus border+padding
			width_focus = math.floor((vim.o.columns - 5) * 0.25), -- 25% of screen minus border+padding
			width_preview = math.floor((vim.o.columns - 3) * 0.5), -- 50% of screen minus border+padding,
		},
	})

	local function explore_from_here()
		MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
		MiniFiles.reveal_cwd()
	end

	-- stylua: ignore start
	vim.keymap.set("n", "-", function() explore_from_here() end, { desc = "Open file browser (mini)" })
	-- stylua: ignore end
end)

now(function()
	add({
		source = "sindrets/diffview.nvim",
	})

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Show diff" })
	vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewOpen main...HEAD<cr>", { desc = "Show diff for branch" })
	-- stylua: ignore end
end)

later(function() -- mini.etc
	require("mini.git").setup()
	require("mini.icons").setup()
	require("mini.diff").setup()
end)
