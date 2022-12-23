-- Rerun all config blocks in lazy.nvim packages
local function retrigger_lazy_config_blocks()
	local plugins = require("lazy").plugins()
	for _, plugin in ipairs(plugins) do
		if plugin.config then
			plugin.config()
		end
	end
end

-- Reload neovim config
local function reload()
	vim.g.hot_reload = true
	local reload_module = require("plenary.reload").reload_module
	reload_module("core")
	reload_module("packages")
	reload_module("custom")

	vim.cmd("luafile " .. vim.env.MYVIMRC)
	retrigger_lazy_config_blocks()
	vim.cmd([[doautocmd User VeryLazy]])
	vim.notify(" Config reloaded")
end

return { reload = reload }
