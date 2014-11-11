if globpath(&rtp, "plugin/syntastic.vim") != ""
  let g:syntastic_check_on_open=1

  " Syntastic styles
  if has('unix')
    let g:syntastic_error_symbol='✘'
    let g:syntastic_style_error_symbol='▸'
    let g:syntastic_warning_symbol='✘' " ⚠
    let g:syntastic_style_warning_symbol='▸'
  endif
endif
