-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false

vim.opt.clipboard = "" -- Don't use system clipboard
vim.opt.swapfile = false -- Don't write swap files
vim.opt.gdefault = true -- Searches will be global by default
vim.opt.relativenumber = false
-- vim.opt.laststatus = 3

-- vim.opt.formatoptions:remove({ "r", "o" })
-- default: jcroqlnt
-- formatoptions-=r -- don't auto-insert comment leader on enter
-- formatoptions-=o -- don't auto-insert comment leader on o/O

if vim.g.neovide then
  -- https://neovide.dev/configuration.html
  vim.o.guifont = "Iosevka SS14:h14"
  vim.g.neovide_text_gamma = 0.0
  vim.g.neovide_text_contrast = 0.5
end
