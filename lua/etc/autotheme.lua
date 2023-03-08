-- Automatically switch dark or light theme
--
-- require("etc.autotheme").setup({
--   dark = { colorscheme = "rosebones" },
--   light = { colorscheme = "catpuccin" },
-- })

local function get_mode_macos(callback)
  vim.fn.jobstart("defaults read -g AppleInterfaceStyle", {
    on_exit = function(exit_code)
      callback(exit_code == 0 and "dark" or "light")
    end,
  })
end

local function get_mode(callback)
  local uname = vim.loop.os_uname()

  if uname.sysname == "Darwin" then -- "Darwin" | "Linux"
    return get_mode_macos(callback)
  end
end

local function setup(options)
  local opts = options or {}

  get_mode(function(mode)
    if mode == "dark" then
      vim.o.background = "dark"
      if opts.dark and opts.dark.colorscheme then
        vim.cmd("colorscheme " .. opts.dark.colorscheme)
      end
    else
      vim.o.background = "light"
      if opts.light and opts.light.colorscheme then
        vim.cmd("colorscheme " .. opts.light.colorscheme)
      end
    end
  end)
end

return { setup = setup }
