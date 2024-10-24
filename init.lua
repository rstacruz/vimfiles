-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if not vim.g.vscode then
  require("lib.autosize").setup()
  require("lib.persist_colorscheme").setup()
end
