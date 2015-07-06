if globpath(&rtp, "plugin/syntastic.vim") == ""
  finish
endif

let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1

" Syntastic styles
if has('unix')
  let g:syntastic_error_symbol='✘'
  let g:syntastic_style_error_symbol='⚑'
  let g:syntastic_warning_symbol='✘' " ⚠
  let g:syntastic_style_warning_symbol='⚑'
endif

if executable('tidy5')
  " http://www.html-tidy.org/
  " https://github.com/htacg/tidy-html5
  let g:syntastic_html_tidy_exec = 'tidy5'
endif

"
" These are slow, so they're opt-in
"

command! Rubocop :call <SID>rubocop()
command! Standard :call <SID>standard()
command! Scsslint :call <SID>scsslint()
command! Semistandard :call <SID>semistandard()

" Usually too noisy with import and variable failures.
let g:syntastic_scss_checkers = ['']
let g:syntastic_sass_checkers = ['']

function! s:rubocop()
  let g:syntastic_ruby_checkers = ['rubocop', 'mri']
  SyntasticCheck
endfunction

function! s:standard()
  let g:syntastic_javascript_checkers = ['standard']
  let g:syntastic_javascript_standard_exec = 'standard'
  SyntasticCheck
endfunction

function! s:semistandard()
  let g:syntastic_javascript_checkers = ['standard']
  let g:syntastic_javascript_standard_exec = 'semistandard'
  SyntasticCheck
endfunction

function! s:scsslint()
  let g:syntastic_scss_checkers = ['scss_lint']
  SyntasticCheck
endfunction
