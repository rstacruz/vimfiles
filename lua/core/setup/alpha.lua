-- local function boxify(input, options)
--   local offset = options and options.offset or 0
--   input = "  " .. input .. "  "
--   return {
--     "╭" .. string.rep("─", string.len(input) + offset + 4) .. "╮",
--     "│  " .. input .. "  │",
--     "╰" .. string.rep("─", string.len(input) + offset + 4) .. "╯",
--   }
-- end

local function get_config()
  -- https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/theta.lua
  local dashboard = require("alpha.themes.dashboard")

  -- buttons
  local section_buttons = {
    type = "group",
    val = {
      dashboard.button("e", "  New file", "<cmd>ene<cr>"),
      dashboard.button("r", "  Open", "<cmd>lua require('core.actions').open_file_picker()<cr>"),
      dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button(",", "  Browse files", "<cmd>e .<cr>"),
      dashboard.button(".", "  Open terminal", "<cmd>term<cr>"),
    },
    opts = { spacing = 1, hl = "Normal" },
  }

  local section_buttons_2 = {
    type = "group",
    val = {
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
        val = "──",
        opts = { position = "center", hl = "Comment", redraw = true },
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
