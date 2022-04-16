-- Configs I don't use anymore
--
local utils = require("core.utils")
local plugin = utils.plugin
local cmd = vim.cmd

PKGS = {
  -- Scrollbars. Works great but the scrollbars don't reposition well
  -- when using with &winwidth. `nvim-scrollview` is a great alternative
  -- "Xuyuanp/scrollbar.nvim",
}

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
