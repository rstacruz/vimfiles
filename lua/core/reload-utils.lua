local do_reload = function()
	vim.cmd("luafile " .. vim.env.MYVIMRC)
	-- TODO: reload via lazy
	vim.notify(" Config reloaded")
end

-- Reload neovim config
--   reload()
--   reload({ safe = true }) -- Suppress errors

local function reload(options)
	local opts = options or {}
	vim.g.hot_reload = true

	local reload_module = require("plenary.reload").reload_module
	reload_module("core")
	reload_module("coresetup")
	reload_module("custom")

	if opts.safe then
		local is_ok, _ = pcall(do_reload)
		if not is_ok then
			vim.notify(" Config reloading didn't work. Try 'leader-sr' to reload again and show errors.")
		end
	else
		do_reload()
	end
end

-- Automatically compile when writing init.lua
local function setup()
	local group = vim.api.nvim_create_augroup("PackerReload", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = {
			vim.env.MYVIMRC,
			vim.fn.stdpath("config") .. "/lua/custom/*.lua",
			vim.fn.stdpath("config") .. "/lua/core/*.lua",
			vim.fn.stdpath("config") .. "/lua/coresetup/*.lua",
		},
		group = group,
		callback = function()
			vim.schedule(function()
				reload({ safe = true })
			end)
		end,
	})
end

return { reload = reload, setup = setup }
