-- bootstrap lazy.nvim, LazyVim and your plugins

-- prevent "cannot parse shada file" errors
if vim.fn.has('macunix') then
  vim.cmd("set shada+='1000,n~/.cache/nvim/shada")
end

pcall(require, "init-local")
require("etc.theme_overrides").setup()
require("config.lazy")
