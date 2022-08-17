-- Run formatting before saving files
local function setup_autoformat()
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

-- Override settings for terminals
local function setup_terminal_overrides()
	local group = vim.api.nvim_create_augroup("TerminalOverrides", { clear = true })

	vim.api.nvim_create_autocmd("TermOpen", {
		pattern = "*",
		group = group,
		callback = function()
			vim.cmd("setlocal nonumber norelativenumber nocursorline")
			vim.cmd("startinsert")
		end,
	})
end

-- Override settings for gitcommit files
local function setup_gitcommit_overrides()
	local group = vim.api.nvim_create_augroup("GitCommitOverrides", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "gitcommit", "NeogitCommitMessage" },
		group = group,
		callback = function()
			vim.cmd("setlocal nonumber norelativenumber nocursorline")
			vim.cmd("startinsert")
		end,
	})
end

local function setup()
	setup_autoformat()
	setup_terminal_overrides()
	setup_gitcommit_overrides()
end

return { setup = setup }
