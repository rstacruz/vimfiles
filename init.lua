require("core.setup.nvim-options").setup()

vim.g.baseconfig = {
  theme = "terafox"
}

local function packages(use)
  use("EdenEast/nightfox.nvim")
  use("lewis6991/impatient.nvim") -- Improve startup time by optimising Lua cache
  use({ "dstein64/vim-startuptime", event = "User DeferredLoad" }) -- Profile startup
  use({"folke/which-key.nvim", event = "User DeferredLoad", config = function()
    require("core.setup.keybindings").setup()
  end }) -- Menu when pressing [space]
end

-- Packer bootstrap
local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
-- if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
if not vim.fn.filereadable(packer_path .. "/lua/packer.lua") then
  print("Installing packer...")
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
  vim.cmd("autocmd User PackerCompileDone luafile " .. vim.env.MYVIMRC)
  vim.cmd("packadd packer.nvim")
  require("packer").startup(packages)
  require("packer").sync()
  return
end

require("packer").startup(packages)
require("impatient")

vim.cmd([[colorscheme terafox]])

local function setup_deferred_loading(callback)
  local group = vim.api.nvim_create_augroup("deferredload", { clear = true })

  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    group = group,
    callback = function()
      vim.defer_fn(function()
        vim.cmd([[doautocmd User DeferredLoad]])
        callback()
      end, 1)
    end,
  })
end

setup_deferred_loading(function()
  -- pass
end)
