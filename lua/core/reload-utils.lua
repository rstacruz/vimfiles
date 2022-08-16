-- Reload neovim config
local function reload()
	-- Refresh the impatient caches
	vim.cmd("LuaCacheClear")

	-- Unload everything from core and coresetup
	for k, _ in pairs(package.loaded) do
		if string.match(k, "^core") or string.match(k, "^custom") then
			package.loaded[k] = nil
		end
	end

	-- Force-reload telescope
	vim.g.loaded_telescope = 0

	-- Signal to some configs that this is a hot-reload
	vim.g.hot_reload = 1

	vim.cmd("luafile " .. vim.env.MYVIMRC)
	require("packer").compile()
	require("packer").install()
	vim.notify(" Config reloaded")

	-- Manually fire off the lazy-loaded modules
	vim.cmd("doautocmd User OnIdle")
	vim.cmd("doautocmd User OnFileLoad")
end

-- Automatically compile when writing init.lua
local function setup()
	local group = vim.api.nvim_create_augroup("PackerReload", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = {
			vim.env.MYVIMRC,
			vim.fn.stdpath("config") .. "/lua/custom/init.lua",
			vim.fn.stdpath("config") .. "/lua/coresetup/keybindings.lua",
		},
		group = group,
		callback = function()
			vim.schedule(function()
				reload()
			end)
		end,
	})
end

return { setup = setup, reload = reload }
