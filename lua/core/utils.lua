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

  local bgcolor = vim.fn.system("cat " .. colors_file .. " | head -n 1")
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

return {
  has_pkg = has_pkg,
  plugin = plugin,
  is_light = is_light,
  reload = reload,
}
