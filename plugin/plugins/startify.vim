if globpath(&rtp, "plugin/startify.vim") == ""
  finish
endif

" if globpath(&rtp, "bin/motd") != ""
"   let g:startify_custom_header = split(system("bash " . globpath(&rtp, "bin/motd")), '\n')
" endif


let g:startify_files_number           = 10
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 0
let g:startify_session_delete_buffers = 1

if !exists('g:startify_bookmarks')
  let g:startify_bookmarks = []
endif

let g:startify_commands = [
  \ ]

let g:startify_list_order = [
  \ 'commands',
  \ [' → Sessions'],
  \ 'sessions',
  \ [' → LRU'],
  \ 'dir',
  \ ]

" \ ['   Sessions:'],
" \ 'sessions',
" \ ['   LRU:'],
" \ 'files',
" \ [' → Bookmarks'],
" \ 'bookmarks',
"
"
