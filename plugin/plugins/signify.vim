if globpath(&rtp, "plugin/signify.vim") == ""
  finish
endif

" It's not like there's any other out there, is there?
let g:signify_vcs_list = [ 'git' ]

" Signs
let g:signify_sign_add               = '+'
let g:signify_sign_change            = '~'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '·'

" Skip for some filetypes
let g:signify_skip_filetype = { 'taskpaper': 1 }
