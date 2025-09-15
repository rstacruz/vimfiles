local M = {}

-- shim for nvim-web-devicons
-- Useful for Diffview: https://github.com/sindrets/diffview.nvim/pull/571/files
M.get_icon = function(name, ext, opts)
	return require("mini.icons").get("file", name)
end

return M
