if globpath(&rtp, "plugin/neomake.vim") == "" | finish | endif

let g:neomake_airline = 1

let g:neomake_error_sign = {
  \ 'text': '✗',
  \ 'texthl': 'Error',
  \ }

let g:neomake_warning_sign = {
  \ 'text': '⚠',
  \ 'texthl': 'Error',
  \ }

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_scss_scsslint_args = ['-c', globpath(&rtp, 'misc/scss-lint.yml')]
autocmd! BufWritePost * Neomake

function! s:standard()
  let g:neomake_javascript_enabled_makers = ['standard']
  let g:neomake_javascript_standard_maker = {
    \ 'args': ['-f', 'compact', '--parser', 'babel-eslint', '-v'],
    \ 'errorformat': '  %f:%l:%c: %m'
    \ }

  let g:neomake_jsx_enabled_makers = ['standard']
  let g:neomake_jsx_standard_maker =
    \ g:neomake_javascript_standard_maker
  Neomake
endfunction

command! Standard :call <SID>standard()

function! s:semistandard()
  let g:neomake_javascript_enabled_makers = ['semistandard']
  let g:neomake_javascript_semistandard_maker = {
    \ 'args': ['-f', 'compact', '--parser', 'babel-eslint', '-v'],
    \ 'errorformat': '  %f:%l:%c: %m'
    \ }

  let g:neomake_jsx_enabled_makers = ['semistandard']
  let g:neomake_jsx_semistandard_maker =
    \ g:neomake_javascript_semistandard_maker
  Neomake
endfunction

command! Semistandard :call <SID>semistandard()
