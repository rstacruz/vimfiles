if globpath(&rtp, "plugin/startify.vim") == ""
  finish
endif

let g:startify_files_number           = 5
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 0
let g:startify_session_delete_buffers = 1

if !exists('g:startify_bookmarks')
  let g:startify_bookmarks = []
endif

let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ ]

let g:startify_custom_header = [
  \ " ",
  \ '  ╻ ╻   ╻   ┏┳┓',
  \ '  ┃┏┛   ┃   ┃┃┃',
  \ '  ┗┛    ╹   ╹ ╹',
  \ '  ',
  \ ] +
  \ map(split(system('bash -c "if [ -e ./__NOTES ]; then cat ./__NOTES; fi"'), '\n'), '"   ". v:val')
