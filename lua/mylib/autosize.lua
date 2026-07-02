-- autosize: resizes windows to 80 cols as you go
-- just like `winwidth` but excludes sidebars and more
--
-- example:
--   require("mylib.autosize").setup()
--   require("mylib.autosize").toggle()

local settings = {
	enabled = true,
	excluded_filetypes = {
		"aerial",
		"AiderConsole",
		"Avante",
		"AvanteInput",
		"AvanteSelectedFiles",
		"codediff-explorer",
		"DiffviewFiles",
		"minifiles",
		"neo-tree",
		"NvimTree",
		"Outline",
		"snacks_input",
		"snacks_picker_list",
		"TelescopePrompt",
		"TelescopeResults",
	},
	min_width = 90,
}

local function is_floating(win_id)
	local win_config = vim.api.nvim_win_get_config(win_id)
	return win_config.relative ~= ""
end

local function run_autosize()
	if not settings.enabled then
		return
	end

	-- don't run on vimdiff
	if vim.api.nvim_get_option_value("diff", { scope = "local" }) then
		return
	end

	-- if vim.api.nvim_get_option_value("buftype", { scope = "local" }) == "terminal" then
	--   return
	-- end

	local win_id = vim.api.nvim_get_current_win()

	if is_floating(win_id) then
		return
	end

	if vim.tbl_contains(settings.excluded_filetypes, vim.bo.filetype) then
		return
	end

	if vim.tbl_contains(settings.excluded_filetypes, vim.bo.filetype) then
		return
	end
	local before = vim.o.winwidth
	vim.o.winwidth = settings.min_width
	vim.o.winwidth = before
	vim.w.autosize_used = 1
end

local function disable()
	settings.enabled = false
end

local function enable()
	settings.enabled = true
	run_autosize()
end

local function toggle()
	if settings.enabled then
		disable()
	else
		enable()
	end
end

local function setup(opts)
	settings = vim.tbl_extend("keep", settings, opts or {})

	vim.api.nvim_create_autocmd("WinEnter", {
		group = vim.api.nvim_create_augroup("autosize", { clear = true }),
		callback = function()
			-- If a window has been autosized before, run it immediately
			if vim.w.autosize_used == 1 then
				return run_autosize()
			end

			-- Otherwise, for first time windows, wait for a while before
			-- autosizing. It might be a sidebar (eg, neotree) that hasn't
			-- loaded yet
			vim.defer_fn(run_autosize, 25)
		end,
	})
end

return { setup = setup, enable = enable, disable = disable, toggle = toggle }
