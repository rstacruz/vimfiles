if !exists('g:loaded_telescope') | finish | endif

lua << EOF
require('telescope').setup {
  defaults = {
    preview = {
      -- makes previews slow
      treesitter = false
    }
  }
}
EOF
