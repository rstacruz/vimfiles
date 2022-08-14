local function setup_scrollview()
  local has, scrollview = pcall(require, "scrollview")
  if not has then
    return
  end

  scrollview.setup()
  vim.g.scrollview_excluded_filetypes = { "NvimTree" }
end

local function setup_indent_blankline()
  local has, indent_blankline = pcall(require, "indent_blankline")
  if not has then
    return
  end

  indent_blankline.setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  })

  vim.g.indent_blankline_show_first_indent_level = true
  vim.g.indent_blankline_char_list = { "│" }
  vim.g.indent_blankline_context_char_list = { "│" }
  vim.g.indent_blankline_filetype_exclude = {
    "lspinfo",
    "packer",
    "checkhealth",
    "",
    "startify",
    "toggleterm",
    "help",
    "spectre_panel",
  }
end

local function setup_lualine()
  local has, lualine = pcall(require, "lualine")
  if not has then
    return
  end

  local lualine_theme = require("core.lib.theme").get_lualine_theme()
  local opts = require("core.lib.lualine-theme").get_theme({ theme = lualine_theme })

  lualine.setup(opts)
end

local function setup_gitsigns()
  local has, gitsigns = pcall(require, "gitsigns")
  if not has then
    return
  end

  gitsigns.setup({
    signs = {
      changedelete = { text = "▌" }, -- Originally "~"
      change = { text = "▌" },
      add = { text = "▌" },
    },
  })
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

local function setup_comment()
  local has, comment = pcall(require, "Comment")
  if not has then
    return
  end
  comment.setup()
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

local function setup_nvim_tree()
  local has, nvim_tree = pcall(require, "nvim-tree")
  if not has then
    return
  end

  nvim_tree.setup({
    sync_root_with_cwd = true,
    view = {
      width = 30,
    },
    renderer = {
      add_trailing = false,
      special_files = {
        "Cargo.toml",
        "Makefile",
        ".gitignore",
        -- docs
        "README.md",
        -- js
        "package.json",
        "package-lock.json",
        "yarn.lock",
        ".babelrc",
        ".babel.config.js",
        ".babel.config.cjs",
        ".babel.config.mjs",
        ".prettierrc",
        ".npmrc",
        "postcss.config.js",
        "tailwind.config.js",
        "tsconfig.json",
        "jsconfig.json",
        -- lua
        ".luarc.json",
        "packer.lock",
        "stylua.toml",
      },
      indent_markers = {
        enable = true,
      },
    },
  })
end

local function setup_later()
  setup_comment()
  setup_gitsigns()
  setup_hop()
  setup_indent_blankline()
  setup_null_ls()
  setup_nvim_gps()
  setup_scrollview()
  setup_spectre()
  setup_workspaces()
end

local function setup()
  setup_lualine()
  setup_nightfox()
  setup_notify()
  setup_nvim_tree()
end

return { setup = setup, setup_later = setup_later }
-- vim:foldmethod=indent
