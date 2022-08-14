-- Reload neovim config
local function reload()
	for k, _ in pairs(package.loaded) do
		if string.match(k, "^core") then
			package.loaded[k] = nil
		end
	end
	vim.cmd("luafile " .. vim.env.MYVIMRC)
end

return { reload = reload }
