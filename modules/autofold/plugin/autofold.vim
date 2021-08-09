command! AutofoldEnable call s:autofold_enable()
command! AutofoldDisable call s:autofold_disable()
command! Autofold call s:autofold_toggle()

function! s:autofold_enable()
  normal zMzv
  if get(b:, 'autofold', 0) == 1 | call s:autofold_disable() | endif
  let b:autofold = 1
  let b:autofold_cmd = 'zMzv'
  augroup autofold
    autocmd CursorMoved <buffer> silent! normal b:autofold_cmd
  augroup END
endfunction

function! s:autofold_disable()
  if get(b:, 'autofold', 0) == 0 | return | endif
  let b:autofold = 0
  augroup autofold
    autocmd! CursorMoved <buffer>
  augroup END
endfunction

function! s:autofold_toggle()
  if get(b:, 'autofold', 0) == 0
    echomsg "Autofold [on]"
    call s:autofold_enable()
  else
    echomsg "Autofold [off]"
    call s:autofold_disable()
  endif
endfunction
