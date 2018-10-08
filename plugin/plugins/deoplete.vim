if globpath(&rtp, "plugin/deoplete.vim") == "" | finish | endif

let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
  \ 'max_list': 100
  \ })

" https://github.com/Shougo/deoplete.nvim/issues/298
set completeopt-=preview

" https://github.com/mhartington/deoplete-typescript#experimental-javascript-support
" let g:deoplete#sources#tss#javascript_support = 1

" let g:deoplete#enable_debug = 1
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')
