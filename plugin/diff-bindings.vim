function! SetDiff3Bindings()
  " Pull changes from local/base/remote
  nnoremap <buffer> <F2> :diffget 1<cr>]c
  nnoremap <buffer> <F3> :diffget 2<cr>]c
  nnoremap <buffer> <F4> :diffget 3<cr>]c

  " Previous/next
  nnoremap <buffer> <F6> ]c
  nnoremap <buffer> <F5> [c

  " Focus
  nnoremap <buffer> <F9>  <C-w>t
  nnoremap <buffer> <F10> <C-w>t<C-w>l
  nnoremap <buffer> <F11> <C-w>t<C-w>l<C-w>l
  nnoremap <buffer> <F12> <C-w>b
endfunction

if &diff
  echomsg "Diff3 bindings on"
  autocmd BufWinEnter * setlocal number
  autocmd BufWinEnter * call SetDiff3Bindings()
endif
