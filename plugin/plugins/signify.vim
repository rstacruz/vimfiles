if globpath(&rtp, "plugin/signify.vim") == ""
  finish
endif

let g:signify_sign_add               = '┋'
let g:signify_sign_change            = '•'
let g:signify_sign_delete            = '▸'
let g:signify_sign_delete_first_line = '▸'
let g:signify_skip_filetype = { 'taskpaper': 1 }

" Colors
au BufNewFile,BufRead * hi SignColumn ctermbg=none
au BufNewFile,BufRead * hi SignifySignAdd ctermbg=none ctermfg=2
au BufNewFile,BufRead * hi SignifySignChange ctermbg=none ctermfg=3
au BufNewFile,BufRead * hi SignifySignDelete ctermbg=none ctermfg=1
