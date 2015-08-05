if globpath(&rtp, "plugin/neomake.vim") == "" | finish | endif

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake

function! s:standard()
  let g:neomake_javascript_enabled_makers = ['standard']
  let g:neomake_jsx_enabled_makers = ['standard']
  let g:neomake_javascript_standard_maker = {
    \ 'args': ['-f', 'compact', '--parser', 'babel-eslint'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \ }
  let g:neomake_jsx_standard_maker = {
    \ 'args': ['-f', 'compact', '--parser', 'babel-eslint'],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \ '%W%f: line %l\, col %c\, Warning - %m'
    \ }
  Neomake
endfunction

command! Standard :call <SID>standard()
