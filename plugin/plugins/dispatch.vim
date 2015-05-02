if globpath(&rtp, "plugin/dispatch.vim") == ""
  finish
endif

nnoremap <F9> :Dispatch<CR>
inoremap <F9> <Esc>:Dispatch<CR>i

nnoremap <Leader>d :Dispatch<CR>
nnoremap <Leader>D :Dispatch!<CR>
