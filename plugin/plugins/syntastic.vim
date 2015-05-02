if globpath(&rtp, "plugin/syntastic.vim") == ""
  finish
endif

let g:syntastic_check_on_open=1

" Syntastic styles
if has('unix')
  let g:syntastic_error_symbol='✘'
  let g:syntastic_style_error_symbol='▸'
  let g:syntastic_warning_symbol='✘' " ⚠
  let g:syntastic_style_warning_symbol='▸'
endif

if executable('tidy5')
  " http://www.html-tidy.org/
  " https://github.com/htacg/tidy-html5
  let g:syntastic_html_tidy_exec = 'tidy5'
endif
