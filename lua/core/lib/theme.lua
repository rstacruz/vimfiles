local cmd = vim.cmd
local utils = require("core.utils")

---@type string ("dark" or "light")
local CURRENT_MODE = "dark"

---@class ThemeState
---@field colorscheme string
---@field lualine string
---@field bgmode string
---@type ThemeState
local CURRENT_THEME = {
  colorscheme = "default",
  lualine = "auto",
  bgmode = "dark",
}

local THEMES = {
  light = {
    { if_pkg = "github-nvim-theme", colorscheme = "github_light", lualine = "auto" },
    { if_pkg = "zenbones.nvim", colorscheme = "zenbones", lualine = "zenbones" },
    { if_pkg = "nightfox.nvim", colorscheme = "dawnfox", lualine = "auto" },
    { if_pkg = "zenbones.nvim", colorscheme = "seoulbones", lualine = "auto" },
    { if_pkg = "vim-microtone", colorscheme = "microtone", lualine = "dracula" },
  },
  dark = {
    { if_pkg = "nightfox.nvim", colorscheme = "terafox", lualine = "auto" },
    { if_pkg = "onedark.nvim", colorscheme = "onedark", lualine = "auto" },
    { if_pkg = "zenbones.nvim", colorscheme = "zenbones", lualine = "zenbones" },
    { if_pkg = "catppuccin-nvim", colorscheme = "catppuccin", lualine = "auto" },
    { if_pkg = "github-nvim-theme", colorscheme = "github_dimmed", lualine = "auto" },
  },
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
  -- cmd([[hi! HopNextKey guibg=#ffddaa guifg=#000000]])
  -- cmd([[hi! HopNextKey1 guibg=#ffddaa guifg=#000000]])
  -- cmd([[hi! HopNextKey2 guibg=#ffddaa guifg=#000000]])
  cmd([[hi! link HopNextKey Search]])
  cmd([[hi! link HopNextKey1 Search]])
  cmd([[hi! link HopNextKey2 Search]])

  -- Custom styles
  cmd([[hi! link XxLine LineNr]]) -- borders and lines. also: Vertsplit

  cmd([[hi! link TelescopeNormal Pmenu]])
  cmd([[hi! link TelescopeBorder Pmenu]])
  cmd([[hi! link TelescopePreviewBorder Pmenu]])
  cmd([[hi! link TelescopeResultsBorder Pmenu]])
  cmd([[hi! link TelescopeTitle Search]])

  cmd([[hi! link TelescopePromptNormal CursorLine]])
  cmd([[hi! link TelescopePromptPrefix DevIconsTsx]])
  cmd([[hi! link TelescopePromptBorder CursorLine]])
  cmd([[hi! link TelescopePromptTitle IncSearch]])
  cmd([[hi! link TelescopePromptCounter NonText]])

  cmd([[hi! link IndentBlanklineContextStart CursorLine]]) -- the indent line that started the context
  cmd([[hi! link IndentBlanklineChar XxLine]])
  cmd([[hi! link IndentBlanklineContextChar XxLine]])

  cmd([[hi! link CmpBorder XxLine]]) -- Custom border for cmp completions

  cmd([[hi! link NvimTreeSpecialFile Comment]]) -- Make some files less visible
  cmd([[hi! link NvimTreeIndentMarker NonText]]) -- Make some files less visible
  cmd([[hi! link NvimTreeRootFolder Comment]]) -- make the heading less prominent
  cmd([[hi! link NvimTreeWinSeparator EndOfBuffer]]) -- better visual boundary from tree sidebar to the buffer

  local col = vim.g.colors_name
  local bg = vim.o.background

  -- different themes have different groups that look nice with borders
  if col == "terafox" or col == "nightfox" or col == "carbonfox" then
    cmd([[hi! link XxLine Conceal]])
  end

  if col == "nibble" then
    cmd([[hi! Comment guifg=#8080cc guibg=none gui=italic]])
    cmd([[hi! CursorLine gui=none guibg=#2020aa]]) -- Default was underline only
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
---@param options SetupOptions?
local function setup(options)
  local opts = options or {}
  local mode = opts.mode or (utils.is_light() and "light" or "dark")
  CURRENT_THEME = get_theme(mode)
  CURRENT_MODE = mode
  vim.opt.background = CURRENT_THEME.bgmode

  vim.g.zenbones = {
    lightness = "bright",
    darkness = "warm", -- warm | stark
    solid_linenr = true,
    lighten_cursor_line = 9,
    darken_noncurrent_window = true,
    lighten_noncurrent_window = true,
  }

  vim.g.rosebones = vim.g.zenbones

  local augroup = vim.api.nvim_create_augroup("ThemeOverrides", { clear = true })
  vim.api.nvim_create_autocmd("Colorscheme", {
    pattern = "*",
    group = augroup,
    callback = function()
      apply_overrides()
      vim.defer_fn(apply_overrides, 100) -- dunno why this is needed, but nightfox can override the overrides
    end,
  })

  cmd("color " .. CURRENT_THEME.colorscheme)

  -- hax for applying zenbones config
  if CURRENT_THEME.colorscheme == "zenbones" then
    vim.defer_fn(function()
      cmd("color " .. CURRENT_THEME.colorscheme)
    end, 400)
  end
end

local function toggle_theme()
  local mode = CURRENT_MODE == "dark" and "light" or "dark"
  setup({ mode = mode })
end

return {
  setup = setup,
  get_lualine_theme = get_lualine_theme,
  toggle_theme = toggle_theme,
}
