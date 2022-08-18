local function setup()
	local features = BaseConfig.features
	vim.g.vim_version = vim.version().minor

	-- use filetype.lua instead of filetype.vim. it's enabled by default in
	-- neovim 0.8 (nightly)
	if vim.g.vim_version < 8 then
		vim.g.did_load_filetypes = 0
		vim.g.do_filetype_lua = 1
	end

	vim.opt.backup = false -- No backup files
	vim.opt.fillchars = { eob = " ", vert = "▓" } -- end-of-buffer and vertical split
	vim.opt.foldlevel = 99 -- Fold everything on first load
	vim.opt.gdefault = true -- Search/replace uses `g` flag by default
	vim.opt.mouse = "a" -- Enable mouse support
	vim.opt.pumheight = 10 -- Popup menu height
	vim.opt.scrolloff = 4 -- Scroll padding
	vim.opt.showmode = false -- Don't show '-- INSERT --' in status line
	vim.opt.signcolumn = "yes" -- Always show sign column
	vim.opt.swapfile = false -- Don't write swap files
	vim.opt.termguicolors = true -- Full GUI colours in terminal
	vim.opt.timeoutlen = 200 -- for which-key
	vim.opt.wrap = false -- Word wrap
	vim.opt.clipboard = "unnamedplus" -- Use system clipboard

	-- Status
	vim.opt.title = true -- Show current file name in title bar

	-- Indenting
	vim.opt.expandtab = true
	vim.opt.shiftwidth = 2
	vim.opt.smartindent = true
	vim.opt.tabstop = 2
	vim.opt.softtabstop = 2

	-- Case
	vim.opt.ignorecase = true -- Case insensitive search
	vim.opt.smartcase = true -- Case insensitive by default, unless there's uppercase

	-- Line numbers
	vim.opt.number = true -- Line numbers
	vim.opt.numberwidth = 2 -- Line numbers
	vim.opt.ruler = false -- No "1,1" in status line

	if features.status_line == "feline" then
		vim.opt.laststatus = 3
	end

	-- Disable nvim intro
	vim.opt.shortmess:append("sI")
	vim.opt.signcolumn = "yes"

	-- Splits
	vim.opt.splitbelow = true -- Vertical splits open below
	vim.opt.splitright = true -- Horizontal splits open to the right

	-- left/right arrows will go to the next/previous line
	vim.opt.whichwrap:append("<>[]hl")

	-- leader keys
	vim.g.mapleader = " "
	vim.g.maplocalleader = ","

	if not vim.fn.has("windows") then
		vim.opt.shell = "/bin/bash"
	end

	if vim.fn.has("nvim-0.7") == 1 then
		local vertchar = "▐"
		vim.opt.fillchars = {
			eob = " ",
			vert = vertchar,
			vertright = vertchar,
			vertleft = vertchar,
			verthoriz = vertchar,
			horizup = "━",
			horizdown = "━",
			horiz = "━",
		} -- better vert characters for global statusline
	end

	-- disable some builtin vim plugins
	local default_plugins = {
		"2html_plugin",
		"getscript",
		"getscriptPlugin",
		"gzip",
		"logipat",
		"matchit",
		"tar",
		"tarPlugin",
		"rrhelper",
		"spellfile_plugin",
		"vimball",
		"vimballPlugin",
		"zip",
		"zipPlugin",
		"tutor",
		"rplugin",
		"syntax",
		"synmenu",
		"optwin",
		"compiler",
		"bugreport",
		"ftplugin",
		"netrwSettings",
		"netrwFileHandlers",
	}

	-- Fugitive relies on netrw for :GBrowse
	if not features.github_fugitive then
		vim.list_extend(default_plugins, {
			"netrw",
			"netrwPlugin",
		})
	end

	for _, plugin in pairs(default_plugins) do
		vim.g["loaded_" .. plugin] = 1
	end

	local default_providers = {
		"node",
		"perl",
		"python3",
		"ruby",
	}

	for _, provider in ipairs(default_providers) do
		vim.g["loaded_" .. provider .. "_provider"] = 0
	end

	-- Lazy-load the shada (shared data) file. This saves ~3ms of startup time
	vim.opt.shadafile = "NONE"
	vim.defer_fn(function()
		vim.opt.shadafile = vim.fn.stdpath(vim.g.vim_version > 7 and "state" or "data") .. "/shada/main.shada"
		vim.cmd("silent! rsh")
	end, 100)
end

return { setup = setup }
