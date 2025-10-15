local M = {}

-- foldtext with syntax highlighting
-- taken from LazyVim
function M.foldtext()
	return vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1]
end

function M.foldexpr()
	local ft = vim.bo.filetype
	if ft == "markdown" then
		return vim.treesitter.foldexpr()
	end
	return vim.lsp.foldexpr() or vim.treesitter.foldexpr()
end

return M
