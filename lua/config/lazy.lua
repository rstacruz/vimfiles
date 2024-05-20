-- https://github.com/LazyVim/starter/blob/main/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local imports = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.lang.tailwind" }, -- https://www.lazyvim.org/plugins/extras/lang/tailwind
  -- { import = "lazyvim.plugins.extras.linting.eslint" }, -- https://www.lazyvim.org/plugins/extras/linting/eslint
  -- { import = "lazyvim.plugins.extras.editor.mini-files" },
  -- { import = "lazyvim.plugins.extras.formatting.prettier" },
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
  -- { import = "lazyvim.plugins.extras.lang.json" },
  -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
}

if vim.g.use_lazy_copilot ~= false then
  table.insert(imports, { import = "lazyvim.plugins.extras.coding.copilot" }) -- https://www.lazyvim.org/plugins/extras/coding.copilot
end

table.insert(imports, { import = "plugins" })

require("lazy").setup({
  spec = imports,
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
