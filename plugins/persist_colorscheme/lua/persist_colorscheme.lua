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
local function save()
  local cache_file = get_cache_file()
  local file = io.open(cache_file, "w")
  if not file then
    return
  end

  file:write("vim.opt.background = '" .. vim.o.background .. "'")
  file:write("vim.cmd('colorscheme " .. vim.g.colors_name .. "')")
  file:close()
end

-- Load colorscheme from cache
local function load()
  local cache_file = get_cache_file()

  if vim.fn.filereadable(cache_file) == 1 then
    dofile(cache_file)
  end
end

-- Setup autocmd to save colorscheme on change
local function setup_autocmd()
  vim.api.nvim_create_autocmd("Colorscheme", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("persist_colorscheme", { clear = true }),
    callback = function()
      save()
    end,
  })
end

local function setup()
  setup_autocmd()
  load()
end

return { save = save, load = load, setup = setup }
