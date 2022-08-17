-- Reload neovim config
--   reload()
--   reload({ safe = true }) -- Suppress errors

local function reload(options)
	local opts = options or {}

	-- Refresh the impatient caches
	vim.cmd("LuaCacheClear")

	-- Unload everything from core and coresetup
	for k, _ in pairs(package.loaded) do
		if string.match(k, "^core") or string.match(k, "^custom") then
			package.loaded[k] = nil
		end
	end

	local do_reload = function()
		vim.cmd("luafile " .. vim.env.MYVIMRC)
		require("packer").compile()
		require("packer").install()
		vim.notify(" Config reloaded")

		-- Manually fire off the lazy-loaded modules
		vim.cmd("doautocmd User OnIdle")
		vim.cmd("doautocmd User OnFileLoad")
	end

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
