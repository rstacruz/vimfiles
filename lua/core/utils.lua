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
				vim.cmd([[doautocmd User DeferredLoad]])
				callback()
			end, 1)
		end,
	})
end

return {
	reload = reload,
	setup_deferred_loading = setup_deferred_loading,
}
