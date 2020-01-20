command! Dark :call <SID>darktheme()
command! Light :call <SID>lighttheme()

function! s:darktheme()
  set background=dark
endfunction

function! s:lighttheme()
  set background=light
endfunction
