local function setup_lualine()
  local has, lualine = pcall(require, "lualine")
  if not has then
    return
  end

  local lualine_theme = require("core.lib.theme").get_lualine_theme()
  local opts = require("core.lib.lualine-theme").get_theme({ theme = lualine_theme })

  lualine.setup(opts)
end

local function setup_nvim_gps()
  local has, nvim_gps = pcall(require, "nvim-gps")
  if not has then
    return
  end

  nvim_gps.setup({ separator = " ╱ " })
end

local function setup_hop()
  local has, hop = pcall(require, "hop")
  if not has then
    return
  end

  hop.setup({ keys = "arstgmneiowfpyulcdh" })
end

local function setup_notify()
  local has, notify = pcall(require, "notify")
  if not has then
    return
  end

  notify.setup({ stages = "static" })
  vim.notify = notify
end

local function setup_null_ls()
  local has, _ = pcall(require, "null-ls")
  if not has then
    return
  end

  local formatCommand = vim.lsp.buf.format and "vim.lsp.buf.format()" or "vim.lsp.buf.formatting_seq_sync()"
  vim.cmd([[augroup Nullformat]])
  vim.cmd([[au!]])
  vim.cmd([[au BufWritePre *.lua,*.js,*.jsx,*.ts,*.tsx,*.cjs,*.mjs lua ]] .. formatCommand)
  vim.cmd([[augroup END]])
end

local function setup_spectre()
  local has, spectre = pcall(require, "spectre")
  if not has then
    return
  end

  spectre.setup({
    line_sep_start = "",
    result_padding = "   ",
    line_sep = "",
  })
end

local function setup_nightfox()
  local has, nightfox = pcall(require, "nightfox")
  if not has then
    return
  end
  local override = require("nightfox").override
  override.palettes({
    dawnfox = {
      bg1 = "#fcfbfa",
    },
  })

  nightfox.setup({
    options = {
      styles = {
        comments = "italic",
        keywords = "bold",
      },
    },
  })
end

local function setup_workspaces()
  local has, workspaces = pcall(require, "workspaces")
  if not has then
    return
  end

  local has_alpha, _ = pcall(require, "alpha")

  workspaces.setup({
    global_cd = true,
    hooks = {
      open_pre = { "%bd!" },
      open = { has_alpha and "Alpha" or "e ." },
    },
  })

  local has_telescope, telescope = pcall(require, "telescope")
  if has_telescope then
    telescope.load_extension("workspaces")
  end
end

local function setup_later()
  setup_hop()
  setup_null_ls()
  setup_nvim_gps()
  setup_spectre()
  setup_workspaces()
end

local function setup()
  setup_lualine()
  setup_nightfox()
  setup_notify()
end

return { setup = setup, setup_later = setup_later }
-- vim:foldmethod=indent
