local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local settings = {
  excluded_filetypes = { "NvimTree", "DiffviewFiles", "Outline" },
  min_width = 80,
}

local function setup(opts)
  settings = vim.tbl_extend("keep", settings, opts)

  vim.api.nvim_create_autocmd("WinEnter", {
    group = augroup("autosize_pane"),
    callback = function()
      if not vim.tbl_contains(settings.excluded_filetypes, vim.bo.filetype) and settings.min_width ~= -1 then
        local before = vim.o.winwidth
        vim.o.winwidth = settings.min_width
        vim.o.winwidth = before
      end
    end,
  })
end

return { setup = setup }
