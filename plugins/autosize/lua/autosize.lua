-- autosize: resizes windows to 80 cols as you go
-- just like `winwidth` but excludes sidebars and more
--
-- example:
--   require("autosize").setup()

local settings = {
  excluded_filetypes = {
    "NvimTree",
    "neo-tree",
    "DiffviewFiles",
    "Outline",
    "aerial",
    "minifiles",
    "TelescopePrompt",
    "TelescopeResults",
  },
  min_width = 80,
}

local function run_autosize()
  if not vim.tbl_contains(settings.excluded_filetypes, vim.bo.filetype) and settings.min_width ~= -1 then
    local before = vim.o.winwidth
    vim.o.winwidth = settings.min_width
    vim.o.winwidth = before
    vim.w.autosize_used = 1
  end
end

local function setup(opts)
  settings = vim.tbl_extend("keep", settings, opts or {})

  vim.api.nvim_create_autocmd("WinEnter", {
    group = vim.api.nvim_create_augroup("autosize", { clear = true }),
    callback = function()
      -- If a window has been autosized before, run it immediately
      if vim.w.autosize_used == 1 then
        return run_autosize()
      end

      -- Otherwise, for first time windows, wait for a while before
      -- autosizing. It might be a sidebar (eg, neotree) that hasn't
      -- loaded yet
      vim.defer_fn(run_autosize, 25)
    end,
  })
end

return { setup = setup }
