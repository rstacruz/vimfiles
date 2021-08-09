command! AutofoldEnable call s:autofold_enable()
command! AutofoldDisable call s:autofold_disable()
command! Autofold call s:autofold_toggle()

function! s:autofold_enable()
  if get(b:, 'autofold_mode', 0) != 0 | call s:autofold_disable() | endif
  setlocal foldlevel=0
  normal zxzv
  let b:autofold_mode = 1
  let b:autofold_cmd = 'zxzv'
  augroup autofold
    autocmd CursorMoved <buffer> silent! exe "normal " . b:autofold_cmd
  augroup END
endfunction

function! s:autofold_disable()
  if get(b:, 'autofold_mode', 0) == 0 | return | endif
  let b:autofold = 0
  augroup autofold
    autocmd! CursorMoved <buffer>
  augroup END
endfunction

function! s:autofold_toggle()
  if get(b:, 'autofold_mode', 0) == 0
    echomsg "Autofold [on]"
    call s:autofold_enable()
  else
    echomsg "Autofold [off]"
    call s:autofold_disable()
  endif
endfunction
