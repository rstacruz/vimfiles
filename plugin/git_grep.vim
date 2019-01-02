" Git grep
command! -nargs=* GG call s:Ag(<q-args>)

function! s:Ag(query)
  " New window
  new
  resize

  " Perform an ag search
  silent exec "r!git grep --heading --line-number " . a:query
  set filetype=help

  if line('$') != 1
    " Lines
    silent %s#^\d\+:#  &  #g

    " Filenames
    silent %s#^[^ ]\+$#\r|&| >#g

    " Move cursor to top, renome 2 lines
    normal gg
    normal "_2dd

    " Highlight currenty query
    let @/=a:query
  else
    normal o
    exec "normal a     No results found for `" . a:query . "`"
    normal o
  endif
  set readonly
endfunction
