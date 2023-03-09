-- Automatically switch dark or light theme
--
-- require("etc.autotheme").setup({
--   dark = { colorscheme = "rosebones" },
--   light = { colorscheme = "catpuccin" },
-- })

-- Executes a command, returns { exit_code
local function exec(cmd, callback)
  local out = {}
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, stdout, _)
      for _, line in ipairs(stdout) do
        table.insert(out, line)
      end
    end,
    on_exit = function(exit_code)
      callback({ exit_code = exit_code, stdout = out })
    end,
  })
end

local function get_mode_macos(callback)
  exec("defaults read -g AppleInterfaceStyle", function(result)
    callback(result.exit_code == 0 and "dark" or "light")
  end)
end

local function get_mode_gnome(callback)
  exec("dconf read /org/gnome/desktop/interface/color-scheme", function(result)
    callback(result.stdout[1] == "'default'" and "light" or "dark")
  end)
end

local function get_mode(callback)
  local uname = vim.loop.os_uname()

  if uname.sysname == "Darwin" then -- "Darwin" | "Linux"
    return get_mode_macos(callback)
  end

  if vim.fn.executable("dconf") == 1 then
    return get_mode_gnome(callback)
  end
end

local function use_dark(opts)
  vim.o.background = "dark"
  if opts.dark and opts.dark.colorscheme then
    vim.cmd("colorscheme " .. opts.dark.colorscheme)
  end
end

local function use_light(opts)
  vim.o.background = "light"
  if opts.light and opts.light.colorscheme then
    vim.cmd("colorscheme " .. opts.light.colorscheme)
  end
end

local function use_mode(mode, opts)
  if mode == "dark" then
    use_dark(opts)
  else
    use_light(opts)
  end
end

local function setup(options)
  local opts = options or {}
  local mode = opts.mode or "auto"

  if mode == "auto" then
    get_mode(function(auto_mode)
      use_mode(auto_mode, opts)
    end)
  else
    use_mode(mode, opts)
  end
end

return { setup = setup }
