-- Checks if a given package is available
local function has_pkg(name)
  local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/" .. name
  return vim.fn.empty(vim.fn.glob(path)) == 0
end

-- Loads a module using require(), but does nothing if the module is not present
-- Used for conditionally configuring a plugin depending on whether it's installed
local function plugin(module_name, callback, options)
  local status, mod = pcall(require, module_name)
  if status then
    if options and options["defer"] then
      vim.defer_fn(function()
        callback(mod)
      end, 1000)
    else
      callback(mod)
    end
  end
end

-- Checks if the theme should be light based on Pywal colors
local function is_light()
  local cache = vim.env.XDG_CACHE_DIR or (vim.env.HOME .. "/.cache")

  -- Pywal colors file
  local colors_file = cache .. "/wal/colors"
  if vim.fn.filereadable(colors_file) == 0 then
    return false
  end

  local bgcolor = vim.fn.readfile(colors_file, "", 1)[1]
  return vim.fn.matchstr(bgcolor, "#[efEF]") ~= ""
end

-- Reload vim config
local function reload()
  for k, _ in pairs(package.loaded) do
    if string.match(k, "^core") then
      package.loaded[k] = nil
    end
  end
  vim.cmd([[luafile ~/.config/nvim/init.lua]])
end

-- Autocmd convenience API
local function augroup_lua(name, fn)
  local group = vim.api.nvim_create_augroup(name, { clear = true })
  local autocmd = function(event, pattern, action)
    local options = { pattern = pattern, group = group }
    if type(action) == "string" then
      options.command = action
    end
    if type(action) == "function" then
      options.callback = action
    end
    vim.api.nvim_create_autocmd(event, options)
  end

  fn(autocmd, group)
end

-- Autocmd API that works before Neovim 0.7 (in a limited way)
local function augroup_legacy(name, fn)
  local autocmd = function(event, pattern, action)
    if type(action) == "string" then
      vim.cmd("au " .. event .. " " .. pattern .. " " .. action)
    end
  end

  vim.cmd("augroup " .. name)
  vim.cmd("au!")
  fn(autocmd, name)
  vim.cmd("augroup END")
end

local augroup = vim.fn.has("nvim-0.7") and augroup_lua or augroup_legacy

return {
  has_pkg = has_pkg,
  plugin = plugin,
  is_light = is_light,
  reload = reload,
  augroup = augroup,
}
