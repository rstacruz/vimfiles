local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Load configuration
BaseConfig = require("core.defaults").defaults
-- pcall(require, "custom.init")

-- Set Neovim options
require("coresetup.nvim-options").setup()

-- Lazy packages
local packages = require("core.packages").get_packages(BaseConfig.features)
require("coresetup.lazy").setup(packages)

-- Apply theme
require("core.theme-overrides").setup()
require("core.theme-utils").setup()

-- Defer loading some plugins until Vim is idle
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("core.reload-utils").setup()
    require("coresetup.autocmds").setup()
  end,
})
