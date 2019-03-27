if globpath(&rtp, "plugin/startify.vim") == ""
  finish
endif

let g:startify_files_number           = 18

" Update session automatically as you exit vim
let g:startify_session_persistence    = 1

if !exists('g:startify_bookmarks')
  let g:startify_bookmarks = []
endif

let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ ]

if $MINIMAL_PROMPT != ''
  let g:startify_custom_header = [ '' ]
else
  let g:startify_custom_header = [
    \ "  ",
    \ '   ╻ ╻   ╻   ┏┳┓',
    \ '   ┃┏┛   ┃   ┃┃┃',
    \ '   ┗┛    ╹   ╹ ╹',
    \ '   ',
    \ ] +
    \ map(split(system('bash -c "note=\$PROJECT_NOTES_PATH/\$(basename \$(pwd)).txt; if [ -e \"\$note\" ]; then cat \"\$note\"; fi"'), '\n'), '"   ". v:val')
endif
