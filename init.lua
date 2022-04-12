PKGS = {
  "savq/paq-nvim", -- Paq package manager

  -- Language
  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer", -- Install LSP servers (:LspInstall)
  "sbdchd/neoformat", -- Formatting

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  -- Themes
  "rstacruz/vim-microtone",
  "projekt0n/github-nvim-theme",

  -- File types
  "preservim/vim-markdown", -- Markdown (.md)
  "slim-template/vim-slim", -- Slim (.slim)

  -- UI
  "SmiteshP/nvim-gps", -- Breadcrumbs in the status line
  "Xuyuanp/scrollbar.nvim", -- Scrollbars
  "folke/lsp-colors.nvim", -- Infer some colours needed for LSP
  "folke/which-key.nvim", -- Menu when pressing [space]
  "kyazdani42/nvim-tree.lua", -- File explorer
  "kyazdani42/nvim-web-devicons",
  "lewis6991/gitsigns.nvim", -- Git indicators on the gutter
  "lukas-reineke/indent-blankline.nvim", -- Indent indicators
  "nvim-lua/plenary.nvim", -- for Telescope
  "nvim-lualine/lualine.nvim", -- Status line
  "nvim-telescope/telescope.nvim",
  "onsails/lspkind-nvim", -- Icons on LSP menus

  -- Optimisations
  "lewis6991/impatient.nvim", -- Improve startup time by optimising Lua cache
  "nathom/filetype.nvim", -- Improve startup time

  -- Goodies
  "Darazaki/indent-o-matic", -- Detect indentation automatically
  "akinsho/toggleterm.nvim", -- Terminal
  "jrudess/vim-foldtext", -- Improve appearance of fold text
  "mhinz/vim-startify", -- Show recent files on startup
  "michaeljsmith/vim-indent-object",
  "nvim-pack/nvim-spectre", -- Find files
  "phaazon/hop.nvim", -- Easymotion (gw)
  "rstacruz/vim-gitgrep",
  "thinca/vim-visualstar",
  "tpope/vim-commentary", -- Comments
  "tpope/vim-fugitive", -- Git
  "tpope/vim-rhubarb", -- Fugitive extension for GitHub commands
  "tpope/vim-surround",
  "tpope/vim-unimpaired", -- Toggle key bindings
}

-- Preamble {{{
pcall(require, "impatient") -- Cache Lua packages
local cmd = vim.api.nvim_command

-- Loads a module using require(), but does nothing if the module is not present
-- Used for conditionally configuring a plugin depending on whether it's installed
local function plugin(module_name, callback)
  local status, mod = pcall(require, module_name)
  if status then
    callback(mod)
  end
end

local function has_paq(name)
  local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/" .. name
  return vim.fn.empty(vim.fn.glob(path)) == 0
end
-- }}}

-- Bootstrap {{{
if not has_paq("paq-nvim") then
  local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
  local paq_url = "https://github.com/savq/paq-nvim.git"
  vim.fn.system({ "git", "clone", "--depth=1", paq_url, path })
  vim.cmd("packadd paq-nvim")
  vim.cmd("autocmd User PaqDoneInstall quit")
  local paq = require("paq")
  paq(PKGS)
  paq.install()
end

plugin("paq", function(paq)
  paq(PKGS)
  paq.install()
end)
-- }}}

local theme = require("theme").get()
if theme then cmd("color " .. theme[1]) end

plugin("nvim-treesitter.configs", function(mod) -- {{{
  mod.setup({
    ensure_installed = { "c", "cpp", "javascript", "css", "lua" },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
  })
end) -- }}}

plugin("cmp", function(cmp) -- {{{
  local _, lspkind = pcall(require, 'lspkind')

  cmp.setup({
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    formatting = lspkind and {
      format = lspkind.cmp_format({
        mode = 'symbol',
        maxwidth = 50,
      })
    } or {},
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
end) -- }}}

plugin("scrollbar", function() -- {{{
  vim.api.nvim_command([[
    let g:scrollbar_max_size = 12
    let g:scrollbar_shape = { 'head': '█', 'body': '█', 'tail': '█', }
    let g:scrollbar_highlight = { 'head': 'LineNr', 'body': 'LineNr', 'tail': 'LineNr', }
  ]])

  cmd([[augroup ScrollbarInit]])
  cmd([[au!]])
  cmd([[autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()]])
  cmd([[autocmd WinEnter,FocusGained,BufEnter  * silent! lua require('scrollbar').show()]])
  cmd([[autocmd WinLeave,BufLeave,BufWinLeave,FocusLost,QuitPre * silent! lua require('scrollbar').clear()]])
  cmd([[augroup END]])
end) -- }}}

plugin("nvim-tree", function(mod) -- {{{
  mod.setup({})
end) -- }}}

plugin("indent-o-matic", function(mod) -- {{{
  mod.setup({})
end) -- }}}

plugin("indent_blankline", function(mod) -- {{{
  mod.setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  })
  vim.cmd([[
    let g:indent_blankline_show_first_indent_level = v:true
    let g:indent_blankline_char_list = ['│', '┊', '┆']
    let g:indent_blankline_context_char_list = ['┊']
    let g:indent_blankline_filetype_exclude += ['startify']
  ]])
end) -- }}}

plugin("lualine", function(mod) -- {{{
  local _, gps = pcall(require, "nvim-gps")
  local function is_file()
    return vim.bo.filetype ~= "toggleterm" and
      vim.bo.filetype ~= "NvimTree" and
      vim.bo.filetype ~= "startify"
  end
  local terminal = {
    function() return [[ ]] .. (vim.b.toggle_number or "0") end,
    cond = function() return vim.bo.filetype == "toggleterm" end
  }
  local startify = {
    function() return [[ ]] .. vim.fn.getcwd() end,
    cond = function() return vim.bo.filetype == "startify" end
  }

  mod.setup({
    options = {
      theme = theme[2],
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        { "filename", file_status = false, icon = "", cond = is_file },
        terminal
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    sections = {
      lualine_a = {
        { "filename", file_status = false, icon = "", cond = is_file },
        terminal,
        startify
      },
      lualine_b = {
        {
          'diagnostics',
          source = { 'nvim' },
          sections = { 'error' },
        },
      },
      lualine_c = {
        gps and { gps.get_location, cond = gps.is_available } or {},
      },
      lualine_x = {
        { "filetype", cond = is_file }
      },
      lualine_y = {
        { "location", icon = "", left_padding = 2, cond = is_file },
      },
      lualine_z = {
        {
          "mode",
          fmt = function(str) return str:sub(1, 1) end,
          cond = is_file
        },
      },
    },
    tabline = {
      lualine_a = {},
      lualine_b = {
        {
          "tabs",
          mode = 1,
          tabs_color = {
            -- Same values as the general color option can be used here.
            active = "lualine_a_normal",
            inactive = "lualine_b_inactive",
          },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "branch" },
      lualine_z = {},
    },
  })
end) -- }}}

plugin("which-key", function(mod) -- {{{
  mod.setup({
    window = {
      border = "single",
      margin = { 1, 10, 2, 10 },
    },
    key_labels = {
      ["<leader>"] = "∴",
    },
    icons = {
      breadcrumb = "›",
      separator = "┄",
      group = "",
    },
    layout = {
      align = "center",
      spacing = 7,
    },
  })
  require("keymaps")
end) -- }}}

plugin("gitsigns", function(mod) -- {{{
  mod.setup({})
end) -- }}}

plugin("nvim-gps", function(mod) -- {{{
  mod.setup({
    separator = " ╱ ",
  })
end) -- }}}

plugin("hop", function(mod) -- {{{
  mod.setup({
    keys = "arstgmneiowfpyulcdh",
    -- keys = "1234567890",
  })
end) -- }}}

plugin("toggleterm", function(toggleterm)
  toggleterm.setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 24
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    shading_factor = 2
  })
end)

plugin("nvim-lsp-installer", function(mod) --  {{{
  vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  mod.on_server_ready(function(server)
    local opts = {}
    -- (optional) Customize the options passed to the server
    -- if server.name == 'tsserver' then
    --     opts.root_dir = function() ... end
    -- end

    server:setup(opts)
  end)
end) -- }}}

if has_paq("vim-startify") then -- {{{
  vim.api.nvim_set_var(
    "startify_custom_indices",
    { "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "r", "s", "t", "g", "z", "x", "c", "d", "v" }
  )
  vim.api.nvim_set_var("startify_custom_header", { "    Neovim" })
  vim.api.nvim_set_var("startify_change_to_vcs_root", 1)
  vim.api.nvim_set_var("startify_enable_unsafe", 1)
  vim.api.nvim_command([[
  let g:startify_lists = []
  let g:startify_lists += [ { 'type': 'dir', 'header': ['  Recent files'] } ]
  let g:startify_lists += [ { 'type': 'sessions', 'header': ['  Sessions'] } ]
  ]])
end -- }}}

if has_paq("vim-floaterm") then -- {{{
  vim.api.nvim_set_var("floaterm_width", 0.95)
end -- }}}

if has_paq("neoformat") then -- {{{
  cmd([[augroup Neoformat]])
  cmd([[au!]])
  cmd([[au BufWritePre *.lua,*.js,*.ts,*.tsx undojoin | Neoformat]])
  cmd([[augroup END]])
end -- }}}

-- Vim settings {{{
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " ", vert = "▓" } -- end-of-buffer and vertical split
vim.opt.gdefault = true -- Search/replace uses `g` flag by default
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.shell = "/bin/bash"
vim.opt.shiftwidth = 2
vim.opt.showmode = false -- Don't show '-- INSERT --' in status line
vim.opt.softtabstop = 2
vim.opt.swapfile = false -- Don't write swap files
vim.opt.timeoutlen = 200 -- For which-key
vim.opt.wrap = false -- Word wrap
-- }}}

-- Customisation: terminal (no line numbers) {{{
cmd([[augroup TerminalCustomisations]])
cmd([[au!]])
cmd([[au TermOpen * setlocal nonumber norelativenumber nocursorline]])
cmd([[au TermOpen * startinsert]])
cmd([[augroup END]])
-- }}}

-- Customisation: git (close on ctrl-s) {{{
cmd([[augroup GitCustomisations]])
cmd([[au!]])
cmd([[au FileType gitcommit startinsert]])
cmd([[au FileType gitcommit inoremap <silent> <buffer> <c-s> <esc>:w<cr>G:q<cr>]])
cmd([[au FileType gitcommit nnoremap <silent> <buffer> <c-s> :w<cr>G:q<cr>]])
cmd([[augroup END]])
-- }}}

-- vim:foldmethod=marker
