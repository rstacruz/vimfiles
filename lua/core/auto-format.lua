-- Automatically run formatting
local function setup()
	local pattern = BaseConfig.format.autoformat_files

	if not pattern then
		return
	end

	local group = vim.api.nvim_create_augroup("NullFormat", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = pattern,
		group = group,
		callback = function()
			if vim.lsp.buf.format then
				vim.lsp.buf.format()
			else
				vim.lsp.buf.formatting_seq_sync()
			end
		end,
	})
end

return { setup = setup }
