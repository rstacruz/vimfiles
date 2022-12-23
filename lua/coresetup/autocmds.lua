local config = {
	-- Auto-format on save
	autoformat_files = "*.lua,*.js,*.jsx,*.ts,*.tsx,*.cjs,*.mjs",
}

-- Run formatting before saving files
local function setup_autoformat()
	local pattern = config.autoformat_files
	if not pattern then
		return
	end

	local group = vim.api.nvim_create_augroup("NullFormat", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = pattern,
		group = group,
		callback = function()
			pcall(function()
				vim.lsp.buf.format()
			end)
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

--- Show cursor line only in active window
--- Adapted from https://github.com/folke/dot/blob/master/config/nvim/lua/config/commands.lua
local function setup_auto_cursorline()
	vim.api.nvim_create_autocmd({ "WinEnter" }, {
		callback = function()
			local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
			if ok and cl then
				vim.wo.cursorline = true
				vim.api.nvim_win_del_var(0, "auto-cursorline")
			end
		end,
	})
	vim.api.nvim_create_autocmd({ "WinLeave" }, {
		callback = function()
			local cl = vim.wo.cursorline
			if cl then
				vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
				vim.wo.cursorline = false
			end
		end,
	})
end

--- Auto create dir on save if needed
--- Adapted from https://github.com/folke/dot/blob/master/config/nvim/lua/config/commands.lua
local function setup_auto_create_dir()
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
		callback = function(event)
			local file = vim.loop.fs_realpath(event.match) or event.match

			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
			local backup = vim.fn.fnamemodify(file, ":p:~:h")
			backup = backup:gsub("[/\\]", "%%")
			vim.go.backupext = backup
		end,
	})
end

local function setup_mdx()
	local group = vim.api.nvim_create_augroup("MdxFiletype", { clear = true })
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = group,
		pattern = "*.mdx",
		callback = function()
			vim.opt_local.filetype = "markdown"
		end,
	})
end

local function setup()
	setup_autoformat()
	setup_terminal_overrides()
	setup_gitcommit_overrides()
	setup_auto_cursorline()
	setup_auto_create_dir()
	setup_mdx()
end

return { setup = setup, config = config }
