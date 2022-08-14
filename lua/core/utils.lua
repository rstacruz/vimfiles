-- Reload neovim config
local function reload()
	for k, _ in pairs(package.loaded) do
		if string.match(k, "^core") then
			package.loaded[k] = nil
		end
	end
	vim.cmd("luafile " .. vim.env.MYVIMRC)
	require("packer").compile()
end

local function setup_deferred_loading(callback)
	local group = vim.api.nvim_create_augroup("deferredload", { clear = true })

	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		group = group,
		callback = function()
			vim.defer_fn(function()
				vim.cmd([[doautocmd User OnIdle]])
				if callback then callback() end
			end, 1)
		end,
	})
end

local function on_file_load(callback)
  local augroup_name = "on_file_load"
	local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

	vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
		pattern = "*",
		group = group,
		callback = function()
      vim.api.nvim_del_augroup_by_name(augroup_name)
      callback()
		end,
	})
end

return {
	reload = reload,
	setup_deferred_loading = setup_deferred_loading,
	on_file_load = on_file_load,
}
