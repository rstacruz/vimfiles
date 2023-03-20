local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.linting.eslint" }, -- https://www.lazyvim.org/plugins/extras/linting.eslint
    -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
    -- { import = "lazyvim.plugins.extras.formatting.prettier" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false, -- Don't use git tag versioning (always use latest git)
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- stylua: ignore
      disabled_plugins = {
        "gzip", "2html_plugin", "bugreport", "compiler", "ftplugin", "getscript", "getscriptPlugin", "gzip", "logipat",
        "node_provider", "optwin", "perl_provider", "python3_provider", "rplugin", "rrhelper", "ruby_provider",
        "spellfile_plugin", "synmenu", "syntax", "tar", "tarPlugin", "tarPlugin", "tohtml", "tohtml", "tutor", "tutor",
        "vimball", "vimballPlugin", "zip", "zipPlugin", "zipPlugin",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "netrwFileHandlers",
        -- "netrwSettings",
      },
    },
  },
})
