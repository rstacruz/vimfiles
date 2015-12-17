if globpath(&rtp, "plugin/grepper.vim") == "" | finish | endif

nnoremap <leader>ag :Grepper! -tool ag -open -switch<cr>
nnoremap <leader>*  :Grepper! -tool ag -open -switch -cword<cr>
