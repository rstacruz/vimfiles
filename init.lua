pcall(require, "impatient")
require("core.setup.nvim-options").setup()

vim.g.baseconfig = {
	theme = "terafox",
}

local function packages(use)
  use({ "wbthomason/packer.nvim", opt = true })

	-- Improve startup time by optimising Lua cache
	use("lewis6991/impatient.nvim")

	-- Library for Telescope and many others
	use({ "nvim-lua/plenary.nvim", module = "plenary" })

	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		requires = {
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("core.setup.telescope").setup()
		end,
	})

	-- Profile startup with :StartupTime
	use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

	use({
		"folke/which-key.nvim",
		event = "User DeferredLoad",
		config = function()
			require("core.setup.keybindings").setup()
		end,
	})

	use("EdenEast/nightfox.nvim")
end

-- Packer bootstrap
local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.filereadable(packer_path .. "/lua/packer.lua") == 0 then
	print("Installing packer…")
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
	vim.cmd("autocmd User PackerCompileDone luafile " .. vim.env.MYVIMRC)
	vim.cmd("packadd packer.nvim")
	require("packer").startup(packages)
	require("packer").sync()
	return
end

require("packer").startup(packages)

vim.cmd([[colorscheme terafox]])

local function setup_deferred_loading(callback)
	local group = vim.api.nvim_create_augroup("deferredload", { clear = true })

	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		group = group,
		callback = function()
			vim.defer_fn(function()
				vim.cmd([[doautocmd User DeferredLoad]])
				callback()
			end, 1)
		end,
	})
end

setup_deferred_loading(function()
	-- pass
end)
