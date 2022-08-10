local function setup()
  vim.opt.backup = false -- No backup files
  vim.opt.expandtab = true
  vim.opt.fillchars = { eob = " ", vert = "▓" } -- end-of-buffer and vertical split
  vim.opt.gdefault = true -- Search/replace uses `g` flag by default
  vim.opt.ignorecase = true -- Case insensitive search
  vim.opt.mouse = "a" -- Enable mouse support
  vim.opt.number = true -- Line numbers
  vim.opt.pumheight = 10 -- Popup menu height
  vim.opt.scrolloff = 4 -- Scroll padding
  vim.opt.shiftwidth = 2
  vim.opt.showmode = false -- Don't show '-- INSERT --' in status line
  vim.opt.signcolumn = "yes" -- Always show sign column
  vim.opt.smartcase = true -- Case insensitive by default, unless there's uppercase
  vim.opt.softtabstop = 2
  vim.opt.splitbelow = true -- Vertical splits open below
  vim.opt.splitright = true -- Horizontal splits open to the right
  vim.opt.swapfile = false -- Don't write swap files
  vim.opt.termguicolors = true -- Full GUI colours in terminal
  vim.opt.wrap = false -- Word wrap
  vim.opt.foldlevel = 99 -- Don't fold everything on first load
  vim.opt.timeoutlen = 200 -- for which-key

  if not vim.fn.has("windows") then
    vim.opt.shell = "/bin/bash"
  end

  if vim.fn.has("nvim-0.7") == 1 then
    vim.opt.laststatus = 3 -- Global statusline
    vim.opt.fillchars = {
      eob = " ",
      vert = "▓", -- ▐
      vertright = "▓",
      vertleft = "▓",
      verthoriz = "▓",
      horizup = "━",
      horizdown = "━",
      horiz = "━",
    } -- better vert characters for global statusline
  end

  -- Causes issues with plugins like which-key
  -- if vim.fn.has("nvim-0.8") == 1 then
  --   vim.opt.cmdheight = 0
  -- end
end

return { setup = setup }
