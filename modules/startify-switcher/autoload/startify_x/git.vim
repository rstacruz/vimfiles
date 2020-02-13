function! s:trim(str)
  return substitute(a:str, '[\r\n\s]*$', '', '')
endfunction

function! startify_x#git#get_branch() " {{{
  let output = system('git rev-parse --abbrev-ref HEAD')
  if v:shell_error
    return ''
  endif
  return s:trim(output)
endfunction " }}}

function! startify_x#git#is_dirty() " {{{
  let output = system('git diff --shortstat')
  return v:shell_error == 0 && s:trim(output) != ''
endfunction " }}}

