if !exists('g:loaded_telescope') | finish | endif

lua << EOF
require('telescope').setup {
  defaults = {
    preview = {
      -- makes previews slow
      treesitter = false
    }
  },
  pickers = {
    find_files = { theme = 'ivy' },
    git_files = { theme = 'ivy' }
  }
}
require('telescope').load_extension('fzf')
EOF
