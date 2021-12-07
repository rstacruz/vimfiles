function s:MicrotoneVariant(styles)
  let g:microtone_variants = split(a:styles, " ")
  color microtone
endfunction

command! -nargs=* MicrotoneVariant call s:MicrotoneVariant(<q-args>)
