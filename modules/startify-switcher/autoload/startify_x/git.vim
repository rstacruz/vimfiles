function! startify_x#git#get_branch() " {{{
  return trim(system('git rev-parse --abbrev-ref HEAD'))
endfunction " }}}

function! startify_x#git#is_dirty() " {{{
  return trim(system('git diff --shortstat')) != ''
endfunction " }}}

