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
	setup_terminal_overrides()
	setup_gitcommit_overrides()
end

return { setup = setup }
