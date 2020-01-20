" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" - `:Ag hello` to searrch
" - `alt-a alt-q` to move to quickfix
" - f3/f4 to navigate quickfix
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'alt-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
