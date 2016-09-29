augroup javascript_shortcuts
  au!
  au FileType javascript call <SID>set_js_shortcuts()
augroup END

function! s:set_js_shortcuts()
  imap <buffer> fn<CR> function () {<CR>
endfunction
