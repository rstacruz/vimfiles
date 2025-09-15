local M = {}

-- Persist colorscheme across sessions
--
-- Usage:
--   require("persist_colorscheme").setup()

-- Get cache file
local function get_cache_file()
	local cache_path = vim.fn.stdpath("cache")
	local cache_file = cache_path .. "/colorscheme.lua"
	return cache_file
end

-- Save colorscheme to cache
---@param name string
M.save = function(name)
	local cache_file = get_cache_file()
	local file = io.open(cache_file, "w")
	if not file then
		return
	end

	file:write("vim.opt.background = '" .. vim.o.background .. "'\n")
	file:write("vim.cmd('colorscheme " .. name .. "')")
	-- vim.g.colors_name
	file:close()
end

-- Load colorscheme from cache
M.load = function()
	local cache_file = get_cache_file()

	if vim.fn.filereadable(cache_file) == 1 then
		dofile(cache_file)
		return 1
	end

	return 0
end

-- Setup autocmd to save colorscheme on change
local function setup_autocmd()
	vim.api.nvim_create_autocmd("Colorscheme", {
		pattern = "*",
		group = vim.api.nvim_create_augroup("persist_colorscheme", { clear = true }),
		callback = function(ev)
			M.save(ev.match)
		end,
	})
end

---@class PersistColorschemeOpts
---@field fallback string?

---@param opts PersistColorschemeOpts
M.setup = function(opts)
	local is_loaded = M.load()
	if is_loaded ~= 1 and opts.fallback then
		vim.cmd("colorscheme " .. opts.fallback)
	end
	setup_autocmd()
end

return M
