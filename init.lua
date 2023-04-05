-- bootstrap lazy.nvim, LazyVim and your plugins
-- require('etc.theme_overrides').setup()
require("config.lazy")
pcall(require, "init-local")
