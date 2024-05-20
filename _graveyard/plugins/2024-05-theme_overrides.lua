local config = {
  base = {
    -- Jump2d
    MiniJump2dSpot = { link = "IncSearch" }, -- or PmenuSel, TabLineSel
    MiniJump2dSpotAhead = { link = "IncSearch" },

    -- Borders
    XxLine = { link = "LineNr" },

    NavicSeparator = { link = "XxLine" },
  },
  forestbones = {
    MiniJump2dSpot = { link = "Search" },
    MiniJump2dSpotAhead = { link = "IncSearch" },
  },
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
