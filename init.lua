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
local now, later = MiniDeps.now, MiniDeps.later

-- Convenient config for all things related to language setup (LSP, etc)
local LANG_CONFIG = {
	treesitter = { "lua", "vimdoc", "javascript", "markdown" },
	mason = { "lua-language-server", "prettierd" },
	lsp = { "lua_ls", "vtsls" },
	linters_by_ft = {
		lua = { "luac", "luacheck" },
	},
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "prettierd" },
		fish = { "fish_indent" },
		sh = { "shfmt" },
	},
}

now(function() -- options
	vim.o.tabstop = 2
	vim.o.shiftwidth = 2
end)

now(function() -- tree sitter
	MiniDeps.add({
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

	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.wo.foldlevel = 99
end)

now(function() -- color scheme
	vim.cmd("colorscheme miniautumn")
	require("mylib.persist_colorscheme").setup()
end)

now(function() -- snacks
	MiniDeps.add({ source = "folke/snacks.nvim" })
	vim.g.snacks_animate = false
	require("snacks").setup({
		indent = { enabled = true }, -- needs early setup
	})
end)

later(function() -- lsp [blink, mason, lsponfig]
	MiniDeps.add({ source = "Saghen/blink.cmp", checkout = "v1.6.0" })
	MiniDeps.add({ source = "mason-org/mason.nvim" })
	MiniDeps.add({
		source = "neovim/nvim-lspconfig",
		depends = { "mason-org/mason.nvim", "saghen/blink.cmp" },
	})
	MiniDeps.add({
		source = "mason-org/mason-lspconfig.nvim",
		depends = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
	})
	require("mason").setup({ ensure_installed = LANG_CONFIG.mason })
	require("mason-lspconfig").setup({ ensure_installed = LANG_CONFIG.lsp })

	-- https://github.com/mason-org/mason.nvim?tab=readme-ov-file#configuration
	-- https://neovim.io/doc/user/lsp.html#lsp-quickstart
	-- https://github.com/neovim/nvim-lspconfig
	-- https://www.lazyvim.org/extras/coding/blink
end)

later(function() -- lint
	MiniDeps.add({
		source = "mfussenegger/nvim-lint",
	})
	require("lint").linters_by_ft = LANG_CONFIG.linters_by_ft
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
end)

later(function() -- format
	MiniDeps.add({ source = "stevearc/conform.nvim" })
	require("conform").setup({ formatters_by_ft = LANG_CONFIG.formatters_by_ft })

	vim.keymap.set("n", "<leader>cf", function()
		require("conform").format()
	end, { desc = "Format" })

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
	local function copy_absolute_path()
		local str = vim.fn.expand("%:p")
		vim.fn.setreg('"', str)
		vim.fn.setreg("+", str)
		vim.notify(" " .. str)
	end

	local function copy_absolute_path_range()
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")
		local line_range = ""
		if start_line == end_line then
			line_range = ":" .. start_line
		else
			line_range = ":" .. start_line .. "-" .. end_line
		end
		local str = vim.fn.expand("%:p") .. line_range
		vim.fn.setreg('"', str)
		vim.fn.setreg("+", str)
		vim.notify(" " .. str)
	end

  -- stylua: ignore start
  vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
	vim.keymap.set("n", "<c-p>", function() Snacks.picker.files() end, { desc = "Open file..." })
	vim.keymap.set("n", "<leader>e", function() Snacks.picker.explorer() end, { desc = "Open file browser" })
	vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Switch buffer" })
	vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Change colorscheme" })
	vim.keymap.set("n", "<leader>ux", function() Snacks.picker() end, { desc = "Choose picker" })
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { desc = "Show references" })
	vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, { desc = "Show implementation" })
	vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, { desc = "Go to type definition" })
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
	vim.keymap.set("n", "<leader>fya", function() copy_absolute_path() end, { desc = " Copy absolute path" })
	vim.keymap.set("v", "<leader>fya", function() copy_absolute_path_range() end, { desc = " Copy absolute path with line numbers" })
	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
	-- stylua: ignore end
end)

later(function() -- mini.clue
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

later(function() -- mini.notify
	local notify = require("mini.notify")
	notify.setup({})
	vim.notify = notify.make_notify({})

	vim.keymap.set("n", "<leader>snh", function()
		notify.show_history()
	end, { desc = "Show notification history" })

	-- https://github.com/nvim-mini/mini.notify
end)

later(function() -- mylib.autosize
	require("mylib.autosize").setup()
end)

later(function() -- trouble
	MiniDeps.add({ source = "folke/trouble.nvim" })
	require("trouble").setup({})

	-- stylua: ignore start
	vim.keymap.set("n", "<leader>xx", function() vim.cmd("Trouble diagnostics toggle") end, { desc = "Show diagnostics" })
	-- stylua: ignore end
end)

-- :DepsUpdate
--
-- todo:
-- * blink cmp
-- * akinsho/bufferline
-- * leader-un toggle for numbers
-- * code actions
-- * recent
-- * show diagnostic info on K
-- * snacks.picker.keymaps()
-- * fold appearance
-- * ctrl-h ctrl-l
-- * bufferline
-- * markdown
-- * diffview
