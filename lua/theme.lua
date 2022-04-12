local has_paq = require('utils').has_paq

-- Checks if the theme should be light based on Pywal colors
local function is_light()
  local cache = vim.env.XDG_CACHE_DIR or (vim.env.HOME .. "/.cache")

  -- Pywal colors file
  local colors_file = cache .. "/wal/colors"
  if vim.fn.filereadable(colors_file) == 0 then return false end

  local bgcolor = vim.fn.system("cat " .. colors_file .. " | head -n 1")
  return vim.fn.matchstr(bgcolor, "#[efEF]") ~= ""
end

-- Returns theme to use
local function get_theme()
  if has_paq("github-nvim-theme") then
    return is_light() and {"github_light", "auto"} or {"github_dark", "dracula"}
  end

  if has_paq("vim-microtone") then
    return {"microtone", "dracula"}
  end

  return {"defualt", "auto"}
end

return { get = get_theme, is_light = is_light }
