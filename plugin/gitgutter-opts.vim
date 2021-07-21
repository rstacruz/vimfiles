let g:gitgutter_sign_added = '┆'
let g:gitgutter_sign_modified = '┆'
let g:gitgutter_sign_removed = '┆'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_removed_above_and_below = '_'
let g:gitgutter_sign_modified_removed = '‖'

" disable by default
if exists(':GitGutterDisable')
  GitGitterDisable
endif
