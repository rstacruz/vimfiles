local M = {}

-- foldtext with syntax highlighting
-- taken from LazyVim
function M.foldtext()
	return vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1]
end

function M.foldexpr()
	return vim.lsp.foldexpr() or vim.treesitter.foldexpr()
end

return M
