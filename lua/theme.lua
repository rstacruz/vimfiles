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
  return is_light() and {"github_light", "auto"} or {"github_dark", "auto"}
  -- return {"microtone", "dracula"}
end

return { get = get_theme, is_light = is_light }
