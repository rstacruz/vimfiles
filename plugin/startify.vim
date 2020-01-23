if globpath(&rtp, "autoload/startify.vim") == "" | finish | endif

"
" Lists
"

let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
  \ { 'type': 'commands' },
  \ ]

let g:startify_change_to_vcs_root = 1

" Cursor line
autocmd User Startified setlocal cursorline

" Dvorak
let g:startify_custom_indices = split('udnpyfgcrxmwz1234567890', '\zs')
