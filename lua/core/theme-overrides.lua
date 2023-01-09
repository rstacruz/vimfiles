local config = {
  base = {
    -- HopNextKey = { link = "Search" },
    HopNextKey1 = { link = "HopNextKey" },
    HopNextKey2 = { link = "HopNextKey" },

    -- Borders
    XxLine = { link = "LineNr" },

    -- Pounce
    PounceMatch = { link = "Search" },
    PounceGap = { link = "Search" },
    PounceAccept = { link = "IncSearch" },
    PounceAcceptBest = { link = "IncSearch" },

    -- Telescope
    TelescopeNormal = { link = "Pmenu" },
    TelescopeBorder = { link = "Pmenu" },
    TelescopePreviewBorder = { link = "Pmenu" },
    TelescopeResultsBorder = { link = "Pmenu" },
    TelescopeTitle = { link = "Search" },

    TelescopePromptNormal = { link = "CursorLine" },
    TelescopePromptPrefix = { link = "DevIconsTsx" },
    TelescopePromptBorder = { link = "CursorLine" },
    TelescopePromptTitle = { link = "IncSearch" },
    TelescopePromptCounter = { link = "NonText" },

    -- Indent blankline
    -- xIndentBlanklineContextStart = { link = "CursorLine" }, -- The line that started the context
    -- xIndentBlanklineChar = { link = "XxLine" },
    -- xIndentBlanklineContextChar = { link = "XxLine" },

    -- Treesitter Context
    TreesitterContext = { link = "CursorLine" },

    -- https://github.com/folke/which-key.nvim
    WhichKeyFloat = { link = "Pmenu" }, -- Nicer background especaiily github_dark
    WhichKeyDesc = { link = "Pmenu" },
    WhichKeyGroup = { link = "Type" },

    NavicSeparator = { link = "XxLine" },

    CmpBorder = { link = "XxLine" }, -- Border for completions
    BufferLineFill = { link = "TabLineFill" }, -- looks better in github_light

    NvimTreeSpecialFile = { link = "Comment" }, -- Make some files less visible
    NvimTreeIndentMarker = { link = "NonText" }, -- Make some files less visible
    NvimTreeRootFolder = { link = "Comment" }, -- make the heading less prominent
    NvimTreeWinSeparator = { link = "EndOfBuffer" }, -- better visual boundary from tree sidebar to the buffer
  },
  nibble = {
    Comment = { fg = "#8080cc", bg = "none", italic = 1 },
    CursorLine = { italic = 0, bg = "#2020aa" }, -- Default was underline
    LineNr = { fg = "#5555bb", italic = 0 },
    -- Normal = { bg = "#333366" },
    -- NormalNC = { bg = "#333366" },
  },
  dayfox = {
    XxLine = { link = "VertSplit" }, -- for indent-blanklike
  },
  terafox = {
    XxLine = { link = "Conceal" },
  },
  blue = {
    XxLine = { link = "FloatBorder" },
  },
  github_dimmed = "github_dark",
  nightfox = "dayfox",
  carbonfox = "dayfox",
}

local function apply_list(list)
  for key, value in pairs(list) do
    vim.api.nvim_set_hl(0, key, value)
  end
end

local function apply()
  local colorscheme = vim.g.colors_name

  apply_list(config.base)
  local target = config[colorscheme]

  while type(target) == "string" do
    target = target[target] -- resolve an alias
  end

  if target then
    apply_list(target)
  end
end

local function setup()
  local augroup = vim.api.nvim_create_augroup("ThemeOverrides", { clear = true })
  vim.api.nvim_create_autocmd("Colorscheme", {
    pattern = "*",
    group = augroup,
    callback = apply,
  })
end

return { apply = apply, setup = setup }
