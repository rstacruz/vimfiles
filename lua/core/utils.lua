-- Reload neovim config
local function reload()
  -- Refresh the impatient caches
  vim.cmd("LuaCacheClear")

  -- Unload everything from core and coresetup
  for k, _ in pairs(package.loaded) do
    if string.match(k, "^core") then
      package.loaded[k] = nil
    end
  end

  vim.cmd("luafile " .. vim.env.MYVIMRC)
  require("packer").compile()

  -- Manually fire off the lazy-loaded modules
  vim.cmd("doautocmd User OnIdle")
  vim.cmd("doautocmd User OnFileLoad")
end

---@class BindOnceOptions
---@field group_name string
---@field events table<string>
---@field callback function

-- Bind an event to an autocmd, but only fire it once.
---@param options BindOnceOptions
local function bind_once(options)
  local augroup_name = options.group_name
  local events = options.events
  local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

  vim.api.nvim_create_autocmd(events, {
    pattern = "*",
    group = group,
    callback = function()
      vim.api.nvim_del_augroup_by_name(augroup_name)
      options.callback()
    end,
  })
end

---@param callback function
local function on_file_load(callback)
  bind_once({
    group_name = "on_file_load",
    events = { "BufRead", "BufWinEnter", "BufNewFile" },
    callback = callback
  })
end

---@param callback function
local function on_vimenter(callback)
  bind_once({
    group_name = "on_vimenter",
    events = { "VimEnter" },
    callback = callback
  })
end

-- Works like packer.startup(packages), but also downloads
-- and installs packer. Returns "false" when processing should stop.
local function bootstrap_packer(packages)
  local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.filereadable(packer_path .. "/lua/packer.lua") == 0 then
    print("Installing packer…")
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
    vim.cmd("autocmd User PackerCompileDone luafile " .. vim.env.MYVIMRC)
    vim.cmd("packadd packer.nvim")
    require("packer").startup(packages)
    require("packer").sync()
    return false
  end

  require("packer").startup(packages)
  return true
end

return {
  reload = reload,
  on_file_load = on_file_load,
  on_vimenter = on_vimenter,
  bootstrap_packer = bootstrap_packer,
}
