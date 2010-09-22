function! s:Focus()
  color ae-black
  set fullscreen
  set linespace=10
  set transparency=0
  set nonumber
  set nolist
  set listchars=
  match Error /aaaaa/
  set lines=23
  set columns=80
endfunction

com! Focus call s:Focus()
