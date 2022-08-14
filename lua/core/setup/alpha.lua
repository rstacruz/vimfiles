local function get_config()
  local has_nvim_tree = pcall(require, "nvim-tree")
  local has_telescope = pcall(require, "telescope")

  -- https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/theta.lua
  local dashboard = require("alpha.themes.dashboard")

  -- buttons
  local section_buttons = {
    type = "group",
    val = {
      has_telescope and dashboard.button("o", "  Open file…", "<cmd>lua require('core.actions').open_file_picker()<cr>") or {},
      has_telescope and dashboard.button("r", "  Recent files…", "<cmd>Telescope oldfiles<cr>") or {},
      has_nvim_tree and dashboard.button("-", "  Open file browser", "<cmd>NvimTreeOpen<cr>") or {},
      dashboard.button(".", "  Open terminal", "<cmd>term<cr>"),
    },
    opts = { spacing = 1, hl = "Normal" },
  }

  local section_buttons_2 = {
    type = "group",
    val = {
      dashboard.button("e", "  New file", "<cmd>ene<cr>"),
      dashboard.button("w", "  Switch project…", "<cmd>Telescope workspaces<cr>"),
      dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
    },
    opts = { spacing = 1, hl = "Normal" },
  }

  local config = {
    layout = {
      { type = "padding", val = 5 },
      {
        type = "text",
        val = { "╲    ╱", " ╲  ╱ ", "  ╲╱ ", "" },
        opts = { position = "center", hl = "Comment", redraw = true },
      },
      {
        type = "text",
        val = function()
          local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          return " " .. cwd
        end,
        opts = { position = "center", hl = "Type", redraw = true },
      },
      { type = "padding", val = 1 },
      section_buttons,
      { type = "padding", val = 1 },
      {
        type = "text",
        val = "─────────────────────",
        opts = { position = "center", hl = "VertSplit", redraw = true },
      },
      { type = "padding", val = 1 },
      section_buttons_2,
      { type = "padding", val = 1 },
      -- { type = "group", val = section_mru.val, },
      -- { type = "padding", val = 1 },
    },
    opts = {
      margin = 5,
    },
  }

  return config
end

local function setup_statusline_hooks()
  local laststatus
  local showtabline

  local group = vim.api.nvim_create_augroup("alpha", { clear = true })
  local autocmd = vim.api.nvim_create_autocmd
  autocmd("FileType", {
    pattern = "alpha",
    group = group,
    callback = function()
      laststatus = vim.opt.laststatus
      showtabline = vim.opt.showtabline
      vim.opt.laststatus = 0
      vim.opt.showtabline = 0
    end,
  })
  autocmd("BufUnload", {
    buffer = 0,
    group = group,
    callback = function()
      vim.opt.laststatus = laststatus
      vim.opt.showtabline = showtabline
    end,
  })
end

local function setup()
  local has, alpha = pcall(require, "alpha")
  if not has then
    return
  end

  setup_statusline_hooks()

  local config = get_config()
  alpha.setup(config)
end

return { setup = setup }
