function! WhichKeyFormat(cmd)
  if exists('*which_key#format')
    let cmd2 = which_key#format(a:cmd)
  else
    let cmd2 = which_key#util#format(a:cmd)
  endif

  let labels = g:which_key_labels

  if has_key(labels, cmd2)
    return labels[cmd2]
  endif

  for expr in keys(labels)
    if a:cmd =~ expr
      return labels[expr]
    endif
  endfor

  return cmd2
endfunction

let g:WhichKeyFormatFunc = function('WhichKeyFormat')
