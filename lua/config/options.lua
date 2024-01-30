-- See defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.clipboard = "" -- Don't use system clipboard
vim.opt.swapfile = false -- Don't write swap files
vim.opt.gdefault = true -- Searches will be global by default
vim.opt.fillchars = "eob: " -- No ~ at end of buffer

vim.opt.formatoptions:remove({ "r", "o" })
-- default: jcroqlnt
-- formatoptions-=r -- don't auto-insert comment leader on enter
-- formatoptions-=o -- don't auto-insert comment leader on o/O
