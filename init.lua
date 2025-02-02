-- bootstrap lazy.nvim, LazyVim and your plugins

-- workaround for https://github.com/nvim-lua/plenary.nvim/issues/536
local is_termux = string.find(vim.loop.os_uname().release, "android")
if is_termux and os.getenv("XDG_RUNTIME_DIR") == nil then
  print("XDG_RUNTIME_DIR is not set")
  local prefix = os.getenv("PREFIX")
  vim.fn.setenv("XDG_RUNTIME_DIR", prefix .. "/tmp")
end

pcall(require, "config.local")
require("config.lazy")

if not vim.g.vscode then
  require("lib.autosize").setup()
  require("lib.persist_colorscheme").setup()
end
