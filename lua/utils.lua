-- Checks if a given package is available
local function has_paq(name)
  local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/" .. name
  return vim.fn.empty(vim.fn.glob(path)) == 0
end

-- Clone paq-nvim if it doesn't exist
-- Then install the packages
local function bootstrap_paq(pkgs)
  if not has_paq("paq-nvim") then
    local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
    local paq_url = "https://github.com/savq/paq-nvim.git"
    vim.fn.system({ "git", "clone", "--depth=1", paq_url, path })
    vim.cmd("packadd paq-nvim")
    vim.cmd("autocmd User PaqDoneInstall quit")
    local paq = require("paq")
    paq(pkgs)
    paq.install()
  else
    local paq = require("paq")
    paq(pkgs)
    vim.defer_fn(function()
      paq.install()
    end, 250)
  end
end

-- Loads a module using require(), but does nothing if the module is not present
-- Used for conditionally configuring a plugin depending on whether it's installed
local function plugin(module_name, callback, options)
  local status, mod = pcall(require, module_name)
  if status then
    if options and options["delay"] then
      vim.defer_fn(function()
        callback(mod)
      end, 25)
    else
      callback(mod)
    end
  end
end

return { has_paq = has_paq, bootstrap_paq = bootstrap_paq, plugin = plugin }
