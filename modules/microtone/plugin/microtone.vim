function s:MicrotoneVariant(styles)
  let g:microtone_variants = split(a:styles, ' ')

  if matchstr(g:colors_name, '^microtone') != ''
    exec 'color ' . g:colors_name
  else
    color microtone
  end
endfunction

command! -nargs=* MicrotoneVariant call s:MicrotoneVariant(<q-args>)
