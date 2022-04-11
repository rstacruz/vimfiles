local PKGS = {
  'savq/paq-nvim';
}

local function clone_paq()
  local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    local paq_url = 'https://github.com/savq/paq-nvim.git'
    vim.fn.system { 'git', 'clone', '--depth=1', paq_url, path }
  end
end

local function bootstrap_paq()
  clone_paq()
  vim.cmd('packadd paq-nvim')
  local paq = require('paq')
  vim.cmd('autocmd User PaqDoneInstall quit')
  paq(PKGS)
  paq.install()
end

return { bootstrap_paq = bootstrap_paq }
