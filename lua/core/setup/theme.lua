local cmd = vim.cmd
local utils = require("core.utils")

---@type string ("dark" or "light")
local CURRENT_MODE = "dark"

---@class ThemeState
---@field colorscheme string
---@field lualine string
---@type ThemeState
local CURRENT_THEME = {
  colorscheme = "default",
  lualine = "auto",
  bgmode = "dark"
}

local THEMES = {
  light = {
    { if_pkg = "zenbones.nvim", colorscheme = "zenbones", lualine = "zenbones" },
    { if_pkg = "github-nvim-theme", colorscheme = "github_light", lualine = "auto" },
    { if_pkg = "nightfox.nvim", colorscheme = "dayfox", lualine = "auto" },
    { if_pkg = "zenbones.nvim", colorscheme = "seoulbones", lualine = "auto" },
    { if_pkg = "vim-microtone", colorscheme = "microtone", lualine = "dracula" }
  },
  dark = {
    { if_pkg = "zenbones.nvim", colorscheme = "zenbones", lualine = "zenbones" },
    { if_pkg = "catppuccin-nvim", colorscheme = "catppuccin", lualine = "auto" },
    { if_pkg = "github-nvim-theme", colorscheme = "github_dimmed", lualine = "auto" },
  }
}

---@param bgmode string ("dark" or "light")
---@return ThemeState
local function get_theme(bgmode)
  for _, item in ipairs(THEMES[bgmode]) do
    if utils.has_pkg(item.if_pkg) then
      return { colorscheme = item.colorscheme, lualine = item.lualine, bgmode = bgmode }
    end
  end
  return { colorscheme = "default", lualine = "auto", bgmode = bgmode }
end

local function apply_overrides()
  cmd([[hi! HopNextKey guibg=#ffddaa guifg=#000000]])
  cmd([[hi! HopNextKey1 guibg=#ffddaa guifg=#000000]])
  cmd([[hi! HopNextKey2 guibg=#ffddaa guifg=#000000]])

  local col = vim.g.colors_name
  local bg = vim.o.background

  if col == "nibble" then
    cmd([[hi! Comment guifg=#8080cc guibg=none gui=italic]])
    cmd([[hi! Cursorline gui=none guibg=#2020aa]]) -- Default was underline only
    cmd([[hi! LineNr guifg=#5555bb gui=italic]])
  end

  if ({ seoulbones = 1, rosebones = 1, zenbones = 1, dayfox = 1 })[col] and bg == "light" then
    cmd([[hi! Normal guibg=#ffffff]])
    cmd([[hi! NormalNC guibg=#fafafc]])
  end
end -- }}}

local function get_lualine_theme()
  return CURRENT_THEME.lualine
end

---@class SetupOptions
---@field mode string ("light" or "dark")
---@param options SetupOptions
local function setup(options)
  local opts = options or {}
  local mode = opts.mode or (utils.is_light() and "light" or "dark")
  CURRENT_THEME = get_theme(mode)
  CURRENT_MODE = mode
  vim.opt.background = CURRENT_THEME.bgmode

  vim.g.zenbones = {
    lightness = "bright",
    transparent_background = true,
    solid_linenr = true,
    lighten_noncurrent_window = true,
    lighten_cursor_line = 9,
    darken_noncurrent_window = true,
    lighten_noncurrent_window = true,
  }
  vim.g.rosebones = vim.g.zenbones
  cmd("color " .. CURRENT_THEME.colorscheme)
end

local function toggle_theme()
  local mode = CURRENT_MODE == "dark" and "light" or "dark"
  setup({ mode = mode })
end

return {
  setup = setup,
  get_lualine_theme = get_lualine_theme,
  apply_overrides = apply_overrides,
  toggle_theme = toggle_theme,
}
