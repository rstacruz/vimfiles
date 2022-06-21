-- Configs I don't use anymore
--
local utils = require("core.utils")
local plugin = utils.plugin
local cmd = vim.cmd

function packages(use)
  -- Scrollbars. Works great but the scrollbars don't reposition well
  -- when using with &winwidth. `nvim-scrollview` is a great alternative
  -- "Xuyuanp/scrollbar.nvim",
  use "kyazdani42/nvim-tree.lua" -- File explorer
  use "nanotee/zoxide.vim" -- Integration with zoxide dir changer
  if vim.fn.executable("nnn") then use("luukvbaal/nnn.nvim") end -- File manager
  use { "rose-pine/neovim", as = "rose-pine-nvim" }
end

-- Startify options
if utils.has_paq("vim-startify") then -- {{{
  vim.api.nvim_set_var(
    "startify_custom_indices",
    { "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "r", "s", "t", "g", "z", "x", "c", "d", "v" }
  )
  vim.api.nvim_set_var("startify_custom_header", {
    "       ",
    "   n    i  m",
    "       ",
  })
  vim.api.nvim_set_var("startify_change_to_vcs_root", 1)
  vim.api.nvim_set_var("startify_enable_unsafe", 1)
  vim.api.nvim_command([[
  let g:startify_lists = []
  let g:startify_lists += [ { 'type': 'dir', 'header': ['  Recent files'] } ]
  let g:startify_lists += [ { 'type': 'sessions', 'header': ['  Sessions'] } ]
  ]])
end -- }}}

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
end, { defer = true }) -- }}}

-- This seems to make things slow
plugin("cmp", function(cmp)
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end)

plugin("nvim-tree", function(mod) -- {{{
  mod.setup({
    view = {
      side = "left",
      width = 20,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
    },
  })
  cmd([[augroup NvimtreeFiletypeCustomisations]])
  cmd([[au!]])
  cmd([[au BufWinEnter NvimTree* set cursorline]])
  cmd([[augroup END]])
end) -- }}}

if utils.has_pkg("vimwiki") then
  cmd([[
    let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
  ]])
end

if true then -- Filetype {{{
  -- https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0
end -- }}}

-- Opens a prompt to switch to a project
local function zed()
  vim.ui.input("Switch to project:", function(value)
    if value == nil then
      return
    end

    vim.cmd("silent! NvimTreeClose")
    vim.cmd("silent! %bw!")
    vim.cmd("Z " .. value)
    vim.cmd("e .")
    -- require("telescope.builtin").oldfiles({ only_cwd = true })
  end)
end

-- Auto reload on save
cmd([[au BufWritePost init.lua luafile ~/.config/nvim/init.lua]])
cmd([[au BufWritePost init.lua PackerCompile]])

-- Indent blankline
vim.g.indent_blankline_char_list = { "┊", "┆", "│" }

-- Leader: [m] marks for harpoon
["<leader>m"] = { name = "[m]arks..." },
["<leader>ma"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "[a]dd bookmark" },
["<leader>m."] = { "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>", "Bookmark commands... [.]" },

