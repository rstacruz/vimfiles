function! SetDiff3Bindings()
  " Pull changes from local/base/remote
  nnoremap <leader>1 :diffget 1<cr>]c
  nnoremap <leader>2 :diffget 2<cr>]c
  nnoremap <leader>3 :diffget 3<cr>]c

  " Previous/next
  nnoremap ] ]c
  nnoremap [ [c
endfunction

if &diff
  echomsg "Diff3 bindings on"
  autocmd BufWinEnter * setlocal number
  autocmd BufWinEnter * call SetDiff3Bindings()
endif
