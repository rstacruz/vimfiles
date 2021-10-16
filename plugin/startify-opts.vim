if globpath(&rtp, "autoload/startify.vim") == "" | finish | endif

"
" Lists
"

let pre = '───  '
let g:startify_lists = [
  \ { 'type': 'dir',       'header': startify#pad([pre . 'Recent files']) },
  \ { 'type': 'sessions',  'header': startify#pad([pre . 'Saved sessions']) },
  \ { 'type': 'bookmarks', 'header': startify#pad([pre . 'Bookmarks']) },
  \ { 'type': 'commands' },
  \ ]

let g:startify_change_to_vcs_root = 1

" Cursor line
autocmd User Startified setlocal cursorline

" Start with 1
let g:startify_custom_indices = split('1234567890', '\zs')

let g:startify_custom_header = ['','','','','','','    ✓']
