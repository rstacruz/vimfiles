local PKGS = {
  'savq/paq-nvim';
}

local function clone_paq()
  local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
  local paq_url = 'https://github.com/savq/paq-nvim.git'
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system { 'git', 'clone', '--depth=1', paq_url, path }
  end
end

local function bootstrap_paq()
  clone_paq()
  -- Load Paq
  vim.cmd('packadd paq-nvim')
  local paq = require('paq')
  -- Exit nvim after installing plugins
  vim.cmd('autocmd User PaqDoneInstall quit')
  -- Read and install packages
  paq(PKGS)
  paq.install()
end

return { bootstrap_paq = bootstrap_paq }
