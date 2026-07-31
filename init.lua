local start = (vim.uv or vim.loop).hrtime()

-- Define config table to be able to pass data between scripts
_G.Config = {}

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
_G.Config.Languages = {
	-- stylua: ignore start
	treesitter = { "lua", "vimdoc", "javascript", "typescript", "markdown", "markdown_inline", "css", "astro", "bash", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "graphql", "html", "jsdoc", "json", "tsx", "toml", "xml", "yaml", "c", "sql", "python" },
	-- stylua: ignore end
	mason = { "prettier" }, -- , "copilot-language-server" },
	-- tools (see :Mason)
	lsp = { "vtsls", "tailwindcss", "biome", "eslint" },
	linters_by_ft = {
		lua = {}, -- luacheck
	},
	formatters_by_ft = {
		lua = { "stylua" },
		markdown = { "biome", "prettier" },
		typescript = { "biome", "eslint_d", "prettierd", lsp_format = "fallback" },
		typescriptreact = { "biome", "eslint_d", "prettierd", lsp_format = "fallback" },
		javascript = { "biome", "eslint_d", "prettierd", lsp_format = "fallback" },
		javascriptreact = { "biome", "eslint_d", "prettierd", lsp_format = "fallback" },
		fish = { "fish_indent" },
		sh = { "shfmt" },
	},
}

local CLUES = {}

-- Termux: some tools are only available certain platforms
local is_termux = string.find(vim.loop.os_uname().release, "android")
if not is_termux then
	table.insert(_G.Config.Languages.lsp, "lua_ls")
	table.insert(_G.Config.Languages.mason, "stylua")
end

local is_mac = vim.loop.os_uname().sysname == "Darwin"
if is_mac then
	table.insert(_G.Config.Languages.lsp, "kotlin_lsp")
end

-- Load init.local.lua if it exists
local init_local = vim.fn.stdpath("config") .. "/init.local.lua"
if vim.fn.filereadable(init_local) == 1 then
	dofile(init_local)
end

-- Core ----------------------------------------------------------------------------------

now(function() -- options
	vim.opt.shortmess:append("I") -- disable start screen
	vim.opt.cmdheight = 0
	if vim.fn.has("nvim-0.12") == 1 then
		require("vim._core.ui2").enable({})
	end
	vim.opt.tabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.foldlevel = 99
	vim.opt.updatetime = 500 -- time to show diagnostics
	vim.opt.swapfile = false
	vim.opt.winminwidth = 0 -- c-w | will zoom
	vim.o.mousescroll = "ver:1" -- Slow mouse scroll
	vim.o.shortmess = "CFOSWaco" -- Disable some built-in completion messages
	vim.o.cursorlineopt = "screenline,number" -- Show cursor line per screen line
	vim.o.showmode = false -- Don't show mode in command line
	vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part
	vim.opt.fillchars = {
		foldopen = "",
		foldclose = "",
		fold = " ",
		foldsep = " ",
		diff = "╱",
		eob = " ",
	}
	vim.o.listchars = "extends:…,nbsp:␣,precedes:…,tab:  " -- hide tabs

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
	if vim.g.neovide then
		vim.o.guifont = "Iosevka Medium:h12:w-0.3"
		vim.o.linespace = -2
	end
end)
-- stylua: ignore end

MiniDeps.later(function() -- diagnostics
	-- Neovim has built-in support for showing diagnostic messages. This configures
	-- a more conservative display while still being useful.
	-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
	local diagnostic_opts = {
		-- Show signs on top of any other sign, but only for warnings and errors
		signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },

		-- Show all diagnostics as underline (for their messages type `<Leader>ld`)
		underline = { severity = { min = "HINT", max = "ERROR" } },

		-- Show more details immediately for errors on the current line
		virtual_lines = false,
		virtual_text = {
			current_line = true,
			severity = { min = "ERROR", max = "ERROR" },
		},

		-- Don't update diagnostics when typing
		update_in_insert = false,
	}

	vim.diagnostic.config(diagnostic_opts)
end)

now_if_args(function() -- tree sitter
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "main",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})

	local ts = require("nvim-treesitter")
	ts.setup({
		install_dir = vim.fn.stdpath("data") .. "/site",
	})
	ts.install(_G.Config.Languages.treesitter)

	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) or vim.bo[args.buf].filetype
			if lang then
				pcall(vim.treesitter.start, args.buf, lang)
			end
		end,
	})
end)

now(function() -- color scheme
	-- Feb 2026 favourites
	add({ source = "followLemmi/cyberneon.nvim" }) -- borland-like
	add({ source = "gnfisher/tomorrow-night-blue.nvim" })
	add({ source = "oskarnurm/koda.nvim" }) -- minimal light
	add({ source = "kshinya7/amaranth.nvim" }) -- like panda

	add({ source = "rebelot/kanagawa.nvim" })
	add({ source = "projekt0n/github-nvim-theme" })
	add({ source = "ellisonleao/gruvbox.nvim" })
	add({ source = "deparr/tairiki.nvim" }) -- tomorrow-night-like, light and dark versions
	require("mylib.persist_colorscheme").setup({ fallback = "miniautumn" })
end)

now_if_args(function() -- guess-indent
	-- Detects indentation settings per file (spaces, tabs)
	add({ source = "NMAC427/guess-indent.nvim" })
	require("guess-indent").setup()
end)

now(function() -- snacks: indent guides, dashboard
	add({ source = "folke/snacks.nvim" })
	vim.g.snacks_animate = true

	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = { "*" },
		callback = function()
			local now = (vim.uv or vim.loop).hrtime()
			vim.g.loadtime = now - start
		end,
	})

	require("snacks").dashboard.sections.cwd = function(opts)
		local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		return { text = { cwd } }
	end

	require("snacks").dashboard.sections.startup = function(opts)
		local v = vim.version()
		local version = string.format("%d.%d.%d", v.major, v.minor, v.patch)
		local loadtime = vim.g.loadtime and string.format("%i ms", vim.g.loadtime / 1e6) or ""
		return {
			text = {
				{ "Neovim " .. version, hl = "NonText" },
				{ " ", hl = "NonText" },
				{ "(" .. loadtime .. ")", hl = "NonText" },
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
				{ action = ":ene", desc = "new file", key = "e", padding = 1 },
				{ action = ":CodeDiff", desc = "git status", key = "s", padding = 1 },
				{ action = ":q", desc = "quit", key = "q" },
			},
		},
		sections = {
			{ section = "cwd" },
			{ section = "recent_files", cwd = true, limit = 5, indent = 0, padding = 1 },
			{ section = "keys", indent = 0, padding = 1 },
			{ section = "startup", indent = 0, padding = 1 },
		},
	}

	require("snacks").setup({
		dashboard = no_args and dashboard_opts or {},
		input = { enabled = true }, -- for renames, etc
		-- indent = { enabled = true }, -- needs early setup
		picker = { enabled = true },
	})

	require("mini.indentscope").setup({
		draw = { delay = 0, animation = require("mini.indentscope").gen_animation.none() },
		symbol = "┊",
	})
end)

-- Keymaps -------------------------------------------------------------------------------

local nav_on = false
local nav_modes = { "n", "i", "v", "t" }
local nav_keys = {
	["<C-S-l>"] = { "<Cmd>tabprevious<cr>", "Tab: prev" },
	["<C-S-y>"] = { "<Cmd>tabnext<cr>", "Tab: next" },
	["<C-S-n>"] = { "<Cmd>wincmd h<cr>", "Focus: left" },
	["<C-S-e>"] = { "<Cmd>wincmd j<cr>", "Focus: down" },
	["<C-S-i>"] = { "<Cmd>wincmd l<cr>", "Focus: right" },
	["<C-S-u>"] = { "<Cmd>wincmd k<cr>", "Focus: up" },
	["<C-S-v>"] = { "<Cmd>vsplit<cr>", "Split: vertical" },
	["<C-S-h>"] = { "<Cmd>split<cr>", "Split: horizontal" },
	["<C-S-t>"] = { "<Cmd>tabnew<cr>", "Tab: new" },
	["<C-S-z>"] = { "<C-w>|", "Pane: zoom" },
}
local function apply_nav()
	for key, spec in pairs(nav_keys) do
		if nav_on then
			vim.keymap.set(nav_modes, key, spec[1], { desc = spec[2] })
		else
			vim.keymap.del(nav_modes, key)
		end
	end
end
local function toggle_nav()
	nav_on = not nav_on
	apply_nav()
	vim.notify("Tab nav keymaps: " .. (nav_on and "on" or "off"))
end
nav_on = true
apply_nav()

later(function() -- keys, keymaps
	local MiniPick = require("mini.pick")

	local function copy_git_link()
		local title = vim.fn.expand("%:.")
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")
		if start_line == end_line then
			title = title .. "#L" .. start_line
		elseif start_line > end_line then
			title = title .. "#L" .. end_line .. "-" .. start_line
		else
			title = title .. "#L" .. start_line .. "-" .. end_line
		end

		Snacks.gitbrowse({
			notify = false,
			open = function(url)
				local link = "[" .. title .. "](" .. url .. ")"
				vim.fn.setreg('"', link)
				vim.fn.setreg("+", link)
				vim.notify(" " .. link)
			end,
		})
	end

	local function copy_git_url()
		Snacks.gitbrowse({
			notify = false,
			open = function(url)
				vim.fn.setreg('"', url)
				vim.fn.setreg("+", url)
				vim.notify(" " .. url)
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
	local function copy_basename()
		return copy_path({ expand = "%:t" })
	end
	local function copy_wikilink()
		local name = vim.fn.expand("%:t:r")
		local str = "[[" .. name .. "]]"
		vim.fn.setreg('"', str)
		vim.fn.setreg("+", str)
		vim.notify(" " .. str)
	end

	local function update_and_show_log()
		vim.cmd("DepsUpdate!")
		vim.cmd("DepsShowLog")
	end

	local function close_buffers_and_reset()
		Snacks.bufdelete.all()
		Snacks.dashboard.open()
	end

	local function pick_git_files()
		MiniPick.builtin.files({ tool = "git" })
	end

	local function pick_files()
		MiniPick.builtin.files()
	end

	local function pick_buffers()
		MiniPick.builtin.buffers()
	end

	-- Keymaps: see https://github.com/nvim-mini/MiniMax/blob/main/configs/nvim-0.11/plugin/20_keymaps.lua
	-- System clipboard
	vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
	vim.keymap.set("i", "<C-S-v>", "<C-R>+", { desc = "Paste from clipboard" })

	-- Paste linewise before/after current line
	-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
	vim.keymap.set("n", "[p", '<Cmd>exe "put! " . v:register<CR>', { desc = "Paste above" })
	vim.keymap.set("n", "]p", '<Cmd>exe "put "  . v:register<CR>', { desc = "Paste below" })

	-- Make `23,` go to line 23. Easier to type than `23G`
	vim.keymap.set("n", ",", "G", { desc = "Go to line" })
	vim.keymap.set("v", ",", "G", { desc = "Go to line" })

	-- default keymaps for references, etc
	-- vim.keymap.del("n", "grt")
	-- vim.keymap.del("n", "gri")
	-- vim.keymap.del("n", "grr")
	-- vim.keymap.del("n", "gra")
	-- vim.keymap.del("n", "grn")
	-- vim.keymap.del("n", "grx")

	-- Paste over currently selected text without yanking it
	vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

  -- stylua: ignore start
	vim.keymap.set("n", "<c-z>", "<c-w>|", { desc = "Pane: zoom" })
	vim.keymap.set("n", "<c-p>", pick_git_files, { desc = "Open file in git..." })
	vim.keymap.set("n", "<F1>", function() Snacks.picker.keymaps() end, { desc = "Open keymaps" })

	vim.keymap.set("n", "<leader>,", pick_buffers, { desc = "Switch buffer..." })
	vim.keymap.set("n", "<leader>!s", "<cmd>split ~/.scratchpad.md<cr><C-w>H", { desc = "Open scratchpad" })
	vim.keymap.set("n", "<leader>!c", "<cmd>split CONTEXT.local.md<cr><C-w>H", { desc = "Open context document" })
	vim.keymap.set("n", "<leader>!g", function() vim.cmd("e " .. vim.fn.stdpath("config") .. "/etc/graveyard.lua") end, { desc = "Config: open config graveyard" })
	table.insert(CLUES, { mode = "n", keys = "<leader>um", desc = "+dependencies" })
	vim.keymap.set("n", "<leader>ums", "<cmd>DepsSnapSave<cr>", { desc = "Deps: save snapshot" })
	vim.keymap.set("n", "<leader>uml", "<cmd>DepsSnapLoad<cr>", { desc = "Deps: load snapshot" })
	vim.keymap.set("n", "<leader>umu", update_and_show_log, { desc = "Deps: update dependencies" })
	vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, { desc = "LSP: rename this..." })
	vim.keymap.set("n", "<leader>e", function() Snacks.picker.explorer() end, { desc = "Open file browser (sidebar)" })
	vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete other buffers" })
	vim.keymap.set("n", "<leader>bd", "<cmd>bdelete!<cr>", { desc = "Delete buffer" })
	vim.keymap.set("n", "<leader>qd", close_buffers_and_reset, { desc = "Delete all buffers and open dashboard" })
	vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Recent projects..." })
	vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent({ hidden = true, filter = { cwd = true } }) end, { desc = "Recent files..." })
	vim.keymap.set("n", "<leader>ff", pick_files, { desc = "Open file..." })
	vim.keymap.set("n", "<leader>gh", function() Snacks.gitbrowse() end, { desc = "Open GitHub in browser" })
	vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log_line() end, { desc = "Show git log for line" })
	vim.keymap.set("n", "<leader>fyg", function() copy_git_url() end, { desc = "Copy: copy GitHub URL" })
	vim.keymap.set("n", "<leader>fyG", function() copy_git_link() end, { desc = "Copy: copy GitHub link" })
	vim.keymap.set("n", "<leader>fya", function() copy_absolute_path() end, { desc = "Copy: copy absolute path" })
	vim.keymap.set("n", "<leader>fyr", function() copy_relative_path() end, { desc = "Copy: copy relative path" })
	vim.keymap.set("n", "<leader>fyb", function() copy_basename() end, { desc = "Copy: copy basename" })
	vim.keymap.set("n", "<leader>fyw", function() copy_wikilink() end, { desc = "Copy: copy wikilink" })
	vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Files changed in Git (status)..." })
	vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Close all and exit" })
	vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Search in files via grep..." })
	vim.keymap.set("n", "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Search in files via grep for word..." })
	vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Open keymaps" })
	vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP: show LSP symbols" })
	vim.keymap.set("n", "<leader>s\"", function() Snacks.picker.registers() end, { desc = "Open registers" })
	vim.keymap.set("n", "<leader>u,", function() vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua") end, { desc = "Config: open settings" })
	vim.keymap.set("n", "<leader>ua", function() require("mylib.autosize").toggle() end, { desc = "Toggle autosize" })
	vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Change colorscheme" })
	vim.keymap.set("n", "<leader>ux", function() Snacks.picker() end, { desc = "Snacks: choose picker" })
	vim.keymap.set("n", "<leader>uk", toggle_nav, { desc = "Toggle tab nav keymaps" })

	vim.keymap.set("v", "<leader>fyg", function() copy_git_link() end, { desc = "Copy: copy GitHub URL" })
	vim.keymap.set("v", "<leader>fya", function() copy_absolute_path_range() end, { desc = "Copy: copy absolute path with line numbers" })
	vim.keymap.set("v", "<leader>fyr", function() copy_relative_path_range() end, { desc = "Copy: copy relative path with line numbers" })
	vim.keymap.set("v", "<leader>gh", function() Snacks.gitbrowse() end, { desc = "Open GitHub in browser" })

	vim.keymap.set("x", "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Search in files via grep for word..." })

	vim.keymap.set("n", "g.", function() vim.lsp.buf.code_action() end, { desc = "LSP: code action" })
	vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "LSP: go to declaration" })
	vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "LSP: go to definition" })
	vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "LSP: show implementation" })
	vim.keymap.set("n", "gGr", function() Snacks.picker.lsp_references() end, { desc = "LSP: show references" })
	vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "LSP: go to type definition" })
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "LSP: hover" })

  vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer: prev buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Buffer: next buffer" })

  vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown rendering" })

  -- Terminal escape
	vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
	vim.keymap.set("t", "<Esc><Esc>", "<Esc>")
	-- stylua: ignore end
end)

later(function() -- terminal keymaps
	-- stylua: ignore start
	vim.keymap.set("n", "<leader>tg", "<cmd>tabnew | term lazygit<cr>", { desc = "Terminal: lazygit" })
	vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Terminal: close current tab" })

	-- Terminal
	vim.keymap.set("n", "<leader>t.", "<cmd>term<cr>", { desc = "Terminal: open here" })
	vim.keymap.set("n", "<leader>tj", "<cmd>belowright split | term<cr>", { desc = "Terminal: open to down" })
	vim.keymap.set("n", "<leader>tt", "<cmd>tabnew | term<cr>", { desc = "Terminal: open in tab" })
	vim.keymap.set("n", "<leader>th", "<cmd>leftabove vsplit | term<cr>", { desc = "Terminal: open to left" })
	vim.keymap.set("n", "<leader>tl", "<cmd>rightbelow vsplit | term<cr>", { desc = "Terminal: open to right" })

	-- Claude
	vim.keymap.set("n", "<leader>tc.", "<cmd>tabnew | term claude --dangerously-skip-permissions<cr>", { desc = "Claude: open here" })
	vim.keymap.set("n", "<leader>tct", "<cmd>tabnew | term claude --dangerously-skip-permissions<cr>", { desc = "Claude: open in tab" })
	vim.keymap.set("n", "<leader>tch", "<cmd>leftabove vsplit | term claude --dangerously-skip-permissions<cr>", { desc = "Claude: open to left" })
	vim.keymap.set("n", "<leader>tcj", "<cmd>belowright split | term claude --dangerously-skip-permissions<cr>", { desc = "Claude: open to down" })
	vim.keymap.set("n", "<leader>tcl", "<cmd>rightbelow vsplit | term claude --dangerously-skip-permissions<cr>", { desc = "Claude: open to right" })

	-- Pi
	vim.keymap.set("n", "<leader>tp.", "<cmd>tabnew | term pi<cr>", { desc = "Pi: open here" })
	vim.keymap.set("n", "<leader>tpt", "<cmd>tabnew | term pi<cr>", { desc = "Pi: open in tab" })
	vim.keymap.set("n", "<leader>tpj", "<cmd>belowright split | term pi<cr>", { desc = "Pi: open to down" })
	vim.keymap.set("n", "<leader>tph", "<cmd>leftabove vsplit | term pi<cr>", { desc = "Pi: open to left" })
	vim.keymap.set("n", "<leader>tpl", "<cmd>rightbelow vsplit | term pi<cr>", { desc = "Pi: open to right" })
	-- stylua: ignore end
end)

-- Editing -------------------------------------------------------------------------------

later(function() -- editor: lsp features (mini completion, mason, lspconfig)
	add({ source = "rafamadriz/friendly-snippets" })
	add({ source = "mason-org/mason.nvim" })
	add({
		source = "neovim/nvim-lspconfig",
		depends = { "mason-org/mason.nvim" },
	})
	add({
		source = "mason-org/mason-lspconfig.nvim",
		depends = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
	})

	local MiniCompletion = require("mini.completion")
	local MiniSnippets = require("mini.snippets")
	local capabilities =
		vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), MiniCompletion.get_lsp_capabilities())

	vim.lsp.config("*", { capabilities = capabilities })

	vim.lsp.config("vtsls", {
		settings = {
			typescript = {
				tsserver = {
					-- https://github.com/yioneko/vtsls/blob/175de18b59321d950cbc4c2c4cf55d5bb39b0675/README.md?plain=1#L123
					maxTsServerMemory = 8192,
				},
			},
		},
	})

	MiniSnippets.setup({
		snippets = {
			MiniSnippets.gen_loader.from_lang(),
		},
	})
	MiniSnippets.start_lsp_server()

	MiniCompletion.setup({
		lsp_completion = {
			source_func = "omnifunc",
			auto_setup = false,
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "Enable mini.completion for LSP buffers",
		callback = function(event)
			vim.bo[event.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
		end,
	})

	-- Insert a newline without accepting completion.
	-- Useful for when completion popup is visible, but you need to start a new line.
	-- side effect is that it shows a blank space differently (placeholder)
	-- vim.keymap.set("i", "<space><cr>", "<C-j>")

	-- Mason
	require("mason").setup({})
	require("mason-lspconfig").setup({ ensure_installed = _G.Config.Languages.lsp })

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

	mason_auto_install(_G.Config.Languages.mason)

	-- Also see:
	--
	-- * https://github.com/mason-org/mason.nvim?tab=readme-ov-file#configuration
	-- * https://neovim.io/doc/user/lsp.html#lsp-quickstart
	-- * https://github.com/neovim/nvim-lspconfig
	-- * https://nvim-mini.org/mini.nvim/readmes/mini-completion.html
end)

later(function() -- editor: linting
	add({
		source = "mfussenegger/nvim-lint",
	})
	require("lint").linters_by_ft = _G.Config.Languages.linters_by_ft
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
end)

later(function() -- editor: formatting
	add({ source = "stevearc/conform.nvim" })
	require("conform").setup({
		formatters_by_ft = _G.Config.Languages.formatters_by_ft,
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters = {
			prettier = {
				require_cwd = true,
			},
			biome = {
				require_cwd = true,
			},
			eslint = {
				require_cwd = true,
			},
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
	require("treesitter-context").setup({ mode = "topline", max_lines = 5 })

	-- Jump to context parent
	-- Also consider [t (treesitter parent)
	vim.keymap.set("n", "[t", function()
		require("treesitter-context").go_to_context(vim.v.count1)
	end, { desc = "Treesitter-context: Jump to context", silent = true })

	-- Also see:
	-- https://github.com/nvim-treesitter/nvim-treesitter-context?tab=readme-ov-file#configuration
end)

-- UI ------------------------------------------------------------------------------------

now_if_args(function() -- mini.tabline
	local MiniTabline = require("mini.tabline")

	MiniTabline.setup({
		show_icons = true,
		tabpage_section = "left",
	})

	local orig_make = MiniTabline.make_tabline_string
	MiniTabline.make_tabline_string = function()
		local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		local icon, icon_hl = require("mini.icons").get("directory", cwd)
		return orig_make() .. "%=%#" .. icon_hl .. "#" .. icon .. " " .. "%#LineNr#" .. cwd .. " "
	end

	vim.api.nvim_create_autocmd("DirChanged", {
		desc = "Redraw tabline on cwd change",
		callback = function()
			vim.cmd("redrawtabline")
		end,
	})
end)

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

	vim.opt.laststatus = 3
end)

later(function() -- mini.pick
	require("mini.pick").setup({})
end)

later(function() -- tiny-cmdline: centered floating cmdline
	add({ source = "rachartier/tiny-cmdline.nvim" })
	require("tiny-cmdline").setup()
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

later(function() -- mini.misc helpers
	require("mini.misc").setup()

	MiniMisc.setup_auto_root()
	MiniMisc.setup_restore_cursor()
	MiniMisc.setup_termbg_sync()
end)

later(function() -- mylib.autosize: resize window widths
	require("mylib.autosize").setup()
end)

later(function() -- mylib.terminal_title: terminal labels
	require("mylib.terminal_title").setup()
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

	local function add_cwd_bookmark()
		MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesExplorerOpen",
		desc = "Add MiniFiles cwd bookmark",
		callback = add_cwd_bookmark,
	})

	-- stylua: ignore start
	vim.keymap.set("n", "-", function() explore_from_here() end, { desc = "Open file browser (mini)" })
	-- stylua: ignore end
end)

-- Git -----------------------------------------------------------------------------------

later(function() -- diffbandit
	add({ source = "esmuellert/codediff.nvim" })
	require("codediff").setup({
		explorer = {
			view_mode = "tree",
		},
	})

	-- :CodeDiff
	-- :CodeDiff history
	--
	-- Keymap:
	-- g? - help
	-- t - toggle side by side
	-- gc - toggle compact mode
	-- `-` - stage/unstage
	--
	-- q - quit
	-- [c ]c - next hunk
	-- [f ]f - next file
	-- <leader>hs - stage hunk
	-- <leader>hu - unstage hunk
	-- <leader>hr - reject hunk
	-- stylua: ignore start
	vim.keymap.set("n", "<leader>gd", "<cmd>CodeDiff<cr>", { desc = "Show diff" })
	vim.keymap.set("n", "<leader>gD", "<cmd>CodeDiff origin/main<cr>", { desc = "Show diff for branch" })
	-- stylua: ignore end
end)

later(function() -- blame
	add({ source = "FabijanZulj/blame.nvim" })
	require("blame").setup({ blame_options = { "-w" } })
	vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle window<cr>", { desc = "Show git blame (window)" })
	-- vim.keymap.set("n", "<leader>gB", "<cmd>BlameToggle virtual<cr>", { desc = "Show git blame (virtual)" })
end)

later(function() -- octo
	add({
		source = "pwntester/octo.nvim",
		depends = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
	})
	require("octo").setup({
		picker = "snacks",
		enable_builtin = true,
		file_panel = { icons = false },
	})

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>oi", "<cmd>Octo issue list<cr>", { desc = "Octo: list issues" })
	vim.keymap.set("n", "<leader>op", "<cmd>Octo pr list<cr>", { desc = "Octo: list pull requests" })
	vim.keymap.set("n", "<leader>on", "<cmd>Octo notification list<cr>", { desc = "Octo: list notifications" })
	vim.keymap.set("n", "<leader>os", "<cmd>Octo search<cr>", { desc = "Octo: search GitHub" })
	vim.keymap.set("n", "<leader>od", "<cmd>Octo discussion list<cr>", { desc = "Octo: list discussions" })
	-- stylua: ignore end
end)

-- Markdown ------------------------------------------------------------------------------

now_if_args(function() -- render-markdown
	add({ source = "MeanderingProgrammer/render-markdown.nvim" })
	require("render-markdown").setup({
		restart_highlighter = true,
		render_modes = { "n", "v", "i", "c", "t" },

		heading = {
			width = "block",
			border = { true, true, false, false, false, false },
			border_virtual = true,
			right_pad = 8,
			icons = { "" },
			sign = false,
			-- signs = { "󰎤 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " },
		},

		code = {
			sign = false,
			style = "full",
			width = "block",
			position = "right",
			right_pad = 3,
			left_pad = 2,
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
				wait2 = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo" },
				prio = { raw = "[!]", rendered = "󰄰", highlight = "DiagnosticError" }, -- high priority
				done = { raw = "[x]", rendered = "󰸞", highlight = "DiagnosticOk" },
				fwd = { raw = "[>]", rendered = "󰒊", highlight = "Comment" }, -- nf-md-send
				sched = { raw = "[<]", rendered = "󰃰", highlight = "Comment" }, -- nf-md-calendar_clock
				cancel = { raw = "[~]", rendered = "󰏤", highlight = "DiagnosticWarn" },
				wait = { raw = "[w]", rendered = "󰏤", highlight = "DiagnosticWarn" }, -- actually "win" in obsidian but I like it as wiating
				info = { raw = "[i]", rendered = "󰋼", highlight = "DiagnosticInfo" }, -- nf-md-information -- `i` in obsidian
				idea = { raw = "[l]", rendered = "󰌵", highlight = "DiagnosticWarn" }, -- nf-md-lightbulb -- `I` in obsidian
				pro = { raw = "[p]", rendered = "󰔓", highlight = "DiagnosticOk" }, -- nf-md-thumb_up
				fire = { raw = "[f]", rendered = "󰈸", highlight = "DiagnosticError" }, -- nf-md-fire
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
            datadog = { pattern = "^http[s]?://%a+.datadoghq.com", icon = "󰩃 ", highlight = "RenderMarkdownLink" },
            figma = { pattern = "^http[s]?://%a+.figma.com", icon = " ", highlight = "RenderMarkdownLink" },
            notion = { pattern = "^http[s]?://%a+.notion.so", icon = " ", highlight = "RenderMarkdownLink" },
            googledrive = { pattern = "^http[s]?://drive.google.com", icon = "󰊶 ", highlight = "RenderMarkdownLink", },
            web = { pattern = "^http[s]?://", icon = "󰏌 ", highlight = "RenderMarkdownLink" }, -- nf-md-open_in_new + ctrl-k 1M
				-- stylua: ignore end
			},
		},
	})
end)

now_if_args(function() -- obsidian
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

later(function() -- copilot
	add({ source = "copilotlsp-nvim/copilot-lsp" })

	vim.lsp.enable("copilot_ls")

	-- add({ source = "zbirenbaum/copilot.lua" })
	-- require("copilot").setup({
	-- 	suggestion = {
	-- 		enabled = true,
	-- 		auto_trigger = true,
	-- 		keymap = { accept = "<C-l>" },
	-- 	},
	-- 	nes = {
	-- 		enabled = true,
	-- 		keymap = { accept_and_goto = "<leader><C-l>", accept = false, dismiss = "<Esc>" },
	-- 	},
	-- 	panel = { auto_refresh = true },
	-- 	filetypes = { markdown = true },
	-- })

	vim.keymap.set("n", "<leader>!as", "<cmd>Copilot panel<cr>", { desc = "Open Copilot suggestions panel" })
end)

later(function() -- mole: code annotation notes
	add({ source = "zion-off/mole.nvim", depends = { "MunifTanjim/nui.nvim" } })
	require("mole").setup({
		picker = "snacks",
		keys = {
			start_session = "<leader>ns",
			stop_session = "<leader>nq",
			resume_session = "<leader>nr",
			toggle_window = "<leader>nw",
			annotate = "<leader>na",
		},
	})
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
			-- `s` key (mini.surround, etc.)
			{ mode = "n", keys = "s" },
			{ mode = "x", keys = "s" },
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
			{ mode = "n", keys = "<leader>o", desc = "+github" },
			{ mode = "n", keys = "<leader>b", desc = "+buffer" },
			{ mode = "n", keys = "<leader>f", desc = "+file" },
			{ mode = "n", keys = "<leader>!", desc = "+experimental" },
			{ mode = "n", keys = "<leader>!d", desc = "+debug" },
			{ mode = "n", keys = "<leader>n", desc = "+notes" },
			{ mode = "n", keys = "<leader>q", desc = "+quit" },
			-- Enhance this by adding descriptions for <Leader> mapping groups
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.square_brackets(),
			miniclue.gen_clues.windows({ submode_resize = true }),
			miniclue.gen_clues.z(),
			CLUES,
		},
	})
end)

later(function() -- mini.extra
	require("mini.extra").setup()
end)

later(function() -- mini.comment
	require("mini.comment").setup()
end)

later(function() -- mini.hipatterns
	local hipatterns = require("mini.hipatterns")
	local hi_words = MiniExtra.gen_highlighter.words

	hipatterns.setup({
		highlighters = {
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

later(function() -- mini.trailspace
	require("mini.trailspace").setup()
end)

later(function() -- mini.etc
	-- Better Around/Inside textobjects
	--
	-- Examples
	--  - va)  - [V]isually select [A]round [)]paren
	--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
	--  - ci'  - [C]hange [I]nside [']quote
	-- require("mini.ai").setup()

	-- Add/delete/replace surroundings (brackets, quotes, etc.)
	--
	-- - sa)   - surround add
	-- - sd'   - surround delete
	-- - sr)}  - surround replace
	-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
	require("mini.surround").setup({
		custom_surroundings = {
			-- Markdown strong (visual select -> sas)
			["s"] = { output = { left = "**", right = "**" } },
			-- Markdown emphasis (visual select -> sae)
			["e"] = { output = { left = "_", right = "_" } },
		},
	})

	-- [c ]c - next comment
	-- [d ]d - next diagnostic
	-- [i ]i - next nndent change
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

later(function() -- sessions
	local MiniSessions = require("mini.sessions")
	local session_dir = vim.fn.stdpath("data") .. "/sessions"

	MiniSessions.setup({
		autowrite = true,
		autoread = false,
		directory = session_dir,
		file = "",
		verbose = { read = false, write = false, delete = true },
	})

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>qr", MiniSessions.restart, { desc = "Session: restart Neovim" })
	-- stylua: ignore end
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
	vim.keymap.set("n", "S", flash.jump, { desc = "Flash: jump to" })
	vim.keymap.set("n", "<leader>bt", flash.treesitter, { desc = "Flash: select treesitter node" })
end)

later(function() -- chezmoi
	require("mylib.chezmoi_auto_apply").setup()
end)

now(function() -- flatten: allow `nvim` in terminal
	add({ source = "willothy/flatten.nvim" })
	local flatten = require("flatten")
	flatten.setup({})
end)

later(function()
	if vim.env.UPDATE_DEPS then
		vim.cmd("DepsUpdate! | DepsShowLog")
	end
end)

later(function() -- Auto-close terminal
	-- Automatically close to prevent "[process exited 0]" message
	vim.api.nvim_create_autocmd("TermClose", {
		pattern = "*",
		callback = function()
			-- Check if the process exited successfully (status 0)
			if vim.v.event.status == 0 then
				vim.api.nvim_buf_delete(0, { force = true })
			end
		end,
	})
end)
