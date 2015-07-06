if globpath(&rtp, "plugin/startify.vim") == ""
  finish
endif

" if executable('cowsay')
"   let g:startify_custom_header =
"     \ map(split(system('echo "Yo" | cowsay'), '\n'), '"   ". v:val') + ['','']
" endif


let g:startify_files_number           = 10
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 0
let g:startify_session_delete_buffers = 1

"   let g:startify_bookmarks = []

let g:startify_list_order = [
  \ ['   LRU within this dir:'],
  \ 'dir',
  \ ['   Sessions:'],
  \ 'sessions',
  \ ]

  " \ ['   Bookmarks:'],
  " \ 'bookmarks',
  " \ ['   LRU:'],
  " \ 'files',
