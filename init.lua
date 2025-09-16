local start = (vim.uv or vim.loop).hrtime()

-- Start with `PROF=1 nvim` or `PROF=1 nvim file.txt` to see startup time
if vim.env.PROF then
	local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
	vim.opt.rtp:append(snacks)
	require("snacks.profiler").startup({ startup = { event = "VimEnter" } })
end

-- Load the `mylib` module
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
	require("mini.basics").setup({
		options = {
			extra_ui = true, -- winblend, listchars, pumheight, etc
			win_borders = "rounded",
		},
		autocommands = {
			relnum_in_visual_mode = true,
		},
		mappings = {
			windows = true, -- navigation with <c-hjkl>, resize with <c-arrow>
			option_toggle_prefix = "<leader>u",
		},
		silent = true, -- hide non-error feedback
	})
end

setup_mini()
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local no_args = vim.fn.argc(-1) == 0 and not vim.env.PROF
local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- Config -------------------------------------------------------------------------------

-- Convenient config for all things related to language setup (LSP, etc)
local LANG_CONFIG = {
	-- stylua: ignore start
	treesitter = { "lua", "vimdoc", "javascript", "typescript", "markdown", "markdown_inline", "css", "astro", "bash", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "graphql", "html", "jsdoc", "json", "tsx", "toml", "xml", "yaml", "c" },
	-- stylua: ignore end
	mason = { "prettier" },
	-- tools (see :Mason)
	lsp = { "vtsls", "tailwindcss", "eslint" },
	linters_by_ft = {
		lua = {}, -- luacheck
	},
	formatters_by_ft = {
		lua = { "stylua" },
		markdown = { "prettier" },
		typescript = { "eslint", "prettier", lsp_format = "fallback" },
		typescriptreact = { "eslint", "prettier", lsp_format = "fallback" },
		javascript = { "eslint", "prettier", lsp_format = "fallback" },
		javascriptreact = { "eslint", "prettier", lsp_format = "fallback" },
		fish = { "fish_indent" },
		sh = { "shfmt" },
	},
}

local CLUES = {}

-- Termux: some tools are only available certain platforms
local is_termux = string.find(vim.loop.os_uname().release, "android")
if not is_termux then
	table.insert(LANG_CONFIG.lsp, "lua_ls")
	table.insert(LANG_CONFIG.mason, "stylua")
end

-- Core ----------------------------------------------------------------------------------

now(function() -- options
	vim.opt.shortmess:append("I") -- disable start screen
	vim.opt.laststatus = 0 -- to be set later
	vim.opt.tabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.foldlevel = 99
	vim.opt.updatetime = 500 -- time to show diagnostics
	vim.opt.swapfile = false
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
	if vim.fn.has("nvim-0.11") == 1 then
		vim.opt.winblend = 3 -- reduce from 10 in mini.basics
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

now_if_args(function() -- guess-indent
	-- Detects indentation settings per file (spaces, tabs)
	add({ source = "NMAC427/guess-indent.nvim" })
	require("guess-indent").setup()
end)

now(function() -- snacks: indent guides, dashboard
	add({ source = "folke/snacks.nvim" })
	vim.g.snacks_animate = false

	local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = { "*" },
		callback = function()
			local now = (vim.uv or vim.loop).hrtime()
			vim.g.loadtime = now - start
		end,
	})

	require("snacks").dashboard.sections.startup = function(opts)
		local loadtime = vim.g.loadtime and string.format("Loaded in %.2f ms", vim.g.loadtime / 1e6) or ""
		return {
			text = {
				{ "" .. loadtime, hl = "NonText" },
			},
		}
	end

	local dashboard_opts = {
		formats = {
			key = function(item)
				return { { item.key, hl = "key" } }
			end,

			file = function(item, ctx)
				local fname = vim.fn.fnamemodify(item.file, ":~")

				-- strip cwd
				local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. "/"
				fname = string.gsub(fname, cwd, "")

				fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
				if #fname > ctx.width then
					local dir = vim.fn.fnamemodify(fname, ":h")
					local file = vim.fn.fnamemodify(fname, ":t")
					if dir and file then
						file = file:sub(-(ctx.width - #dir - 2))
						fname = dir .. "/…" .. file
					end
				end
				local dir, file = fname:match("^(.*)/(.+)$")
				return dir and { { file, hl = "file" }, { " " .. dir .. "/", hl = "dir" } }
					or { { fname, hl = "file" } }
			end,
		},
		width = 40,
		preset = {
			keys = {
				{ action = ":ene", desc = "new file", key = "e" },
				{ action = ":DiffviewOpen", desc = "git status", key = "s" },
				{ action = ":q", desc = "quit", key = "q" },
			},
		},
		sections = {
			{ title = "" .. cwd, padding = 1 },
			{ section = "recent_files", cwd = true, limit = 5, indent = 0, padding = 1 },
			{ section = "keys", indent = 0, padding = 1 },
			{ section = "startup", indent = 0, padding = 1 },
		},
	}

	require("snacks").setup({
		dashboard = no_args and dashboard_opts or {},
		input = { enabled = true }, -- for renames, etc
		indent = { enabled = true }, -- needs early setup
	})
end)

-- Keymaps -------------------------------------------------------------------------------

later(function() -- keys, keymaps
	local function copy_git_url()
		Snacks.gitbrowse({
			notify = false,
			open = function(str)
				vim.fn.setreg('"', str)
				vim.fn.setreg("+", str)
				vim.notify(" " .. str)
			end,
		})
	end

	local function copy_path(opts)
		local str = vim.fn.expand(opts.expand)
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")
		if opts and opts.range then
			if start_line == end_line then
				str = str .. "#L" .. start_line
			elseif start_line > end_line then
				str = str .. "#L" .. end_line .. "-" .. start_line
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

	-- Make `23,` go to line 23. Easier to type than `23G`
	vim.keymap.set("n", ",", "G", { desc = "Go to line" })
	vim.keymap.set("v", ",", "G", { desc = "Go to line" })

	-- default keymaps for references, etc
	vim.keymap.del("n", "grt")
	vim.keymap.del("n", "gri")
	vim.keymap.del("n", "grr")
	vim.keymap.del("n", "gra")
	vim.keymap.del("n", "grn")

	-- Paste over currently selected text without yanking it
	vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

  -- stylua: ignore start
	vim.keymap.set("n", "<c-p>", function() Snacks.picker.git_files({ untracked = true }) end, { desc = "Open file in git..." })
	vim.keymap.set("n", "<F1>", function() Snacks.picker.keymaps() end, { desc = "Open keymaps" })

	vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Switch buffer..." })
	vim.keymap.set("n", "<leader>!s", "<cmd>split ~/.scratchpad.md<cr><C-w>H", { desc = "Open scratchpad" })
	vim.keymap.set("n", "<leader>!g", function() vim.cmd("e " .. vim.fn.stdpath("config") .. "/etc/graveyard.lua") end, { desc = "Open config graveyard" })
	table.insert(CLUES, { mode = "n", keys = "<leader>um", desc = "+dependencies" })
	vim.keymap.set("n", "<leader>ums", "<cmd>DepsSnapSave<cr>", { desc = "Deps: save snapshot" })
	vim.keymap.set("n", "<leader>uml", "<cmd>DepsSnapLoad<cr>", { desc = "Deps: load snapshot" })
	vim.keymap.set("n", "<leader>umu", "<cmd>DepsUpdate<cr>", { desc = "Deps: update dependencies" })
	vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, { desc = "Rename this..." })
	vim.keymap.set("n", "<leader>e", function() Snacks.picker.explorer() end, { desc = "Open file browser (sidebar)" })
	vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete other buffers" })
	vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Recent projects..." })
	vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent({ hidden = true, filter = { cwd = true } }) end, { desc = "Recent files..." })
	vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Open file..." })
	vim.keymap.set("n", "<leader>gh", function() Snacks.gitbrowse() end, { desc = "Open GitHub in browser" })
	vim.keymap.set("n", "<leader>fyg", function() copy_git_url() end, { desc = "Copy GitHub URL" })
	vim.keymap.set("n", "<leader>fya", function() copy_absolute_path() end, { desc = " Copy absolute path" })
	vim.keymap.set("n", "<leader>fyr", function() copy_relative_path() end, { desc = " Copy relative path" })
	vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Files changed in Git (status)..." })
	vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Close all and exit" })
	vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Search in files via grep..." })
	vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Open keymaps" })
	vim.keymap.set("n", "<leader>u,", function() vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua") end, { desc = "Open settings" })
	vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Change colorscheme" })
	vim.keymap.set("n", "<leader>ux", function() Snacks.picker() end, { desc = "Choose picker" })

	vim.keymap.set("v", "<leader>fyg", function() copy_git_url() end, { desc = "Copy GitHub URL" })
	vim.keymap.set("v", "<leader>fya", function() copy_absolute_path_range() end, { desc = " Copy absolute path with line numbers" })
	vim.keymap.set("v", "<leader>fyr", function() copy_relative_path_range() end, { desc = " Copy relative path with line numbers" })
	vim.keymap.set("v", "<leader>gh", function() Snacks.gitbrowse() end, { desc = "Open GitHub in browser" })

	vim.keymap.set("n", "g.", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
	vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Go to declaration" })
	vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Go to definition" })
	vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Show implementation" })
	vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Show references" })
	vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Go to type definition" })
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })

  vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
	-- stylua: ignore end
end)

-- Editing -------------------------------------------------------------------------------

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

	-- <C-n>/<C-p> - next or previous match
	-- <c-y> - accept
	-- <cr> - accept
	require("blink.cmp").setup({
		-- <cr> to accept completions. To insert a new line instead, use
		-- <C-j> or <space><cr>
		keymap = { preset = "default", ["<cr>"] = { "accept", "fallback" } },

		-- Show documentation in completion
		completion = { documentation = { auto_show = true } },

		-- Prefers native ("rust") but fallback to Lua implementation
		fuzzy = { implementation = "prefer_rust" },

		-- show signature help when typing (
		signature = { enabled = true },
	})

	-- Insert a newline without accepting completion.
	-- Useful for when completion popup is visible, but you need to start a new line.
	-- side effect is that it shows a blank space differently (placeholder)
	-- vim.keymap.set("i", "<space><cr>", "<C-j>")

	-- Mason
	require("mason").setup({})
	require("mason-lspconfig").setup({ ensure_installed = LANG_CONFIG.lsp })

	-- Automatically pop up after `updatetime` milliseconds
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			vim.diagnostic.open_float(nil, { focus = false })
		end,
	})

	-- Install Mason packages that aren't installed
	---@param pkgs string[]
	local function mason_auto_install(pkgs)
		local mr = require("mason-registry")
		local pkgs_to_install = vim.tbl_filter(function(item)
			local pkg = mr.get_package(item)
			return pkg:is_installed() == false
		end, pkgs)

		if #pkgs_to_install ~= 0 then
			vim.cmd("MasonInstall " .. table.concat(pkgs_to_install, " "))
		end
	end

	mason_auto_install(LANG_CONFIG.mason)

	-- Also see:
	--
	-- * https://github.com/mason-org/mason.nvim?tab=readme-ov-file#configuration
	-- * https://neovim.io/doc/user/lsp.html#lsp-quickstart
	-- * https://github.com/neovim/nvim-lspconfig
	-- * https://www.lazyvim.org/extras/coding/blink
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
	require("conform").setup({
		formatters_by_ft = LANG_CONFIG.formatters_by_ft,
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>cf", function() require("conform").format() end, { desc = "Format" })
	-- stylua: ignore end

	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

	vim.keymap.set("n", "<leader>!df", "<cmd>ConformInfo<cr>", { desc = "Debug: conform formatter info" })
	vim.keymap.set("n", "<leader>!dl", "<cmd>LspInfo<cr>", { desc = "Debug: show lsp info" })

	-- Also see:
	--
	-- * https://github.com/stevearc/conform.nvim?tab=readme-ov-file#setup
	-- * https://www.lazyvim.org/plugins/formatting
end)

later(function() -- various-textobjs: vaq and more
	-- vaq  - select all in quotes " ' `
	-- vab  - select all in brackets ( [ { <
	add({ source = "chrisgrieser/nvim-various-textobjs" })
	require("various-textobjs").setup({})
end)

later(function() -- treesitter-context
	add({ source = "nvim-treesitter/nvim-treesitter-context" })
	require("treesitter-context").setup({ mode = "topline" })

	-- Jump to context parent
	vim.keymap.set("n", "[p", function()
		require("treesitter-context").go_to_context(vim.v.count1)
	end, { desc = "Jump to context", silent = true })

	-- Also see:
	-- https://github.com/nvim-treesitter/nvim-treesitter-context?tab=readme-ov-file#configuration
end)

-- UI ------------------------------------------------------------------------------------

now_if_args(function() -- mini.statusline
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
	---@param value number
	local function defer_laststatus_update_on_insert(value)
		local group = vim.api.nvim_create_augroup("restore", { clear = true })
		vim.api.nvim_create_autocmd("InsertEnter", {
			group = group,
			callback = function()
				vim.opt.laststatus = value
				vim.api.nvim_del_augroup_by_id(group)
			end,
		})
	end

	-- Show status line immediately when starting with a file
	if vim.fn.argc(-1) > 0 then
		vim.opt.laststatus = 2
	else
		defer_laststatus_update_on_insert(2)
	end
end)

later(function() -- mini.notify: toast notifications
	local notify = require("mini.notify")
	notify.setup({
		window = {
			config = {
				anchor = "SE",
				col = vim.o.columns,
				row = vim.o.lines - 2,
				border = "rounded",
			},
		},
		content = {
			format = function(notif)
				-- Don't prepent timestamp
				return string.format("%s    ", notif.msg)
			end,
		},
	})
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
	vim.keymap.set("n", "<leader>xx", "<Cmd>Trouble diagnostics toggle<cr>", { desc = "Show diagnostics" })
	-- stylua: ignore end
end)

later(function() -- mini.files
	local MiniFiles = require("mini.files")
	MiniFiles.setup({
		mappings = {
			go_out = "<Left>", -- default `h`
			go_in = "<Right>", -- default `l`
			go_in_plus = "<cr>", -- open (closes mini.files when used one a file)
			synchronize = "<c-s>", -- save changes (default `=`)
			help = "?", -- default `g?`
			-- also: reveal_cwd (`@`)
		},
		windows = {
			preview = true,
			width_nofocus = 12,
			width_focus = 40,
			width_preview = 40,
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

-- Git -----------------------------------------------------------------------------------

later(function() -- diffview
	add({
		source = "sindrets/diffview.nvim",
	})

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Show diff" })
	vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewOpen main...HEAD<cr>", { desc = "Show diff for branch" })
	-- Within the view:
	-- <leader>cA - choose all
	-- <leader>cB/cO/cT - choose base / ours / theirs
	-- dX - delete conflict region
	-- [x ]x - next conflict
	-- L - open commit log panel
	--
	-- s / - - stage or unstage
	-- S - stage all
	-- gf - open in previous tab
	-- <C-w><C-f> - open in split
	-- <C-w>gf - open in new tab
	--
	-- stylua: ignore end
end)

later(function() -- blame
	add({ source = "FabijanZulj/blame.nvim" })
	require("blame").setup({ blame_options = { "-w" } })
	vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle window<cr>", { desc = "Show git blame (window)" })
	vim.keymap.set("n", "<leader>gB", "<cmd>BlameToggle virtual<cr>", { desc = "Show git blame (virtual)" })
end)

-- Markdown ------------------------------------------------------------------------------

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

later(function() -- obsidian
	-- vaq  - select all in quotes " ' `
	-- vab  - select all in brackets ( [ { <
	add({
		source = "obsidian-nvim/obsidian.nvim",
		depends = { "nvim-lua/plenary.nvim" },
	})

	local Obsidian = require("mylib/obsidian")
	require("obsidian").setup(Obsidian.get_obsidian_options())

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("obsidian_keybindings", { clear = true }),
		pattern = { "markdown" },
		callback = function(event)
			Obsidian.bind_keys(event.buf)
		end,
	})
end)

-- AI ------------------------------------------------------------------------------------

later(function() -- opencode
	add({ source = "NickvanDyke/opencode.nvim", depends = { "folke/snacks.nvim" } })

	local opencode = require("opencode")
	-- stylua: ignore start
	table.insert(CLUES, { mode = "n", keys = "<leader>o", desc = "+opencode" })
	vim.keymap.set("n", "<leader>oa", function() opencode.ask("@cursor: ") end, { desc = "Ask opencode" })
	vim.keymap.set("v", "<leader>oa", function() opencode.ask("@selection: ") end, { desc = "Ask opencode about selection" })
	vim.keymap.set("n", "<leader>ot", function() opencode.toggle() end, { desc = "Toggle embedded opencode" })
	vim.keymap.set("n", "<leader>on", function() opencode.command("session_new") end, { desc = "New session" })
	vim.keymap.set("n", "<leader>oy", function() opencode.command("messages_copy") end, { desc = "Copy last message" })
	vim.keymap.set({ "n", "v" }, "<leader>op", function() opencode.select_prompt() end, { desc = "Select prompt" })
	vim.keymap.set("n", "<S-C-u>", function() opencode.command("messages_half_page_up") end, { desc = "Scroll messages up" })
	vim.keymap.set("n", "<S-C-d>", function() opencode.command("messages_half_page_down") end, { desc = "Scroll messages down" })
	-- stylua: ignore end
end)

later(function() -- copilot
	add({ source = "zbirenbaum/copilot.lua" })
	require("copilot").setup({
		suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<C-l>" } },
		panel = { auto_refresh = true },
		filetypes = {
			markdown = true,
		},
	})

	vim.keymap.set("n", "<leader>!as", "<cmd>Copilot panel<cr>", { desc = "Open Copilot suggestions panel" })
end)

-- Mini ----------------------------------------------------------------------------------

later(function() -- mini.clue: shows keyboard shortcuts
	local miniclue = require("mini.clue")
	miniclue.setup({
		triggers = {
			-- Leader triggers
			{ mode = "n", keys = "<Leader>" },
			{ mode = "x", keys = "<Leader>" },
			-- Built-in completion
			{ mode = "i", keys = "<C-x>" },
			-- jump
			{ mode = "n", keys = "[" },
			{ mode = "n", keys = "]" },
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
			{ mode = "n", keys = "<leader>g", desc = "+git" },
			{ mode = "n", keys = "<leader>b", desc = "+buffer" },
			{ mode = "n", keys = "<leader>f", desc = "+file" },
			{ mode = "n", keys = "<leader>!", desc = "+experimental" },
			{ mode = "n", keys = "<leader>!d", desc = "+debug" },
			{ mode = "n", keys = "<leader>q", desc = "+quit" },
			-- Enhance this by adding descriptions for <Leader> mapping groups
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows(),
			miniclue.gen_clues.z(),
			CLUES,
		},
	})
end)

later(function() -- mini.etc
	-- Better Around/Inside textobjects
	--
	-- Examples
	--  - va)  - [V]isually select [A]round [)]paren
	--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
	--  - ci'  - [C]hange [I]nside [']quote
	require("mini.ai").setup()

	-- Add/delete/replace surroundings (brackets, quotes, etc.)
	--
	-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
	-- - sd'   - [S]urround [D]elete [']quotes
	-- - sr)'  - [S]urround [R]eplace [)] [']
	require("mini.surround").setup()

	-- [c ]c - next comment
	-- [d ]d - next diagnostic
	-- [i ]i - next indent change
	-- [h ]h - next Git hunk
	-- [q ]q - next quickfix file
	-- [l ]l - next loclist file
	-- [t ]t - next treesitter node (eg, parent block)
	require("mini.bracketed").setup()

	-- gS - toggle between one-line and multi-line for function arguments, tables, etc.
	require("mini.splitjoin").setup()

	-- highlight word under cursor
	require("mini.cursorword").setup()

	require("mini.git").setup()
	require("mini.icons").setup()
	require("mini.diff").setup()
end)

later(function() -- marks
	add({ source = "chentoast/marks.nvim" })

	-- marks: highlights marks in the signcolumn, and shows a list of marks
	-- similar to harpoon
	require("marks").setup({})
	table.insert(CLUES, { mode = "n", keys = "<leader>m", desc = "+marks" })
	vim.keymap.set("n", "<leader>ml", "<cmd>MarksListAll<cr>", { desc = "List all marks" })
	vim.keymap.set("n", "<leader>mb", "<cmd>BookmarksListAll<cr>", { desc = "List bookmarks" })
	vim.keymap.set("n", "<leader>mx", "<cmd>delmarks!<cr>", { desc = "Delete all marks" })
end)

later(function() -- flash
	add({ source = "folke/flash.nvim" })
	local flash = require("flash")
	flash.setup({
		modes = {
			-- when using `/` or `?`
			search = { highlight = { backdrop = false } },
			-- when using f F t T ; ,
			char = { highlight = { backdrop = false } },
		},
	})
	vim.keymap.set("n", "S", flash.jump, { desc = "Flash" })
	vim.keymap.set("n", "<leader>bt", flash.treesitter, { desc = "Select treesitter node" })
end)

later(function() -- chezmoi
	require("mylib.chezmoi_auto_apply").setup()
end)
