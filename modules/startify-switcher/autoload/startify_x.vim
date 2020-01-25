if !exists('g:startify_x_use_toilet')
  let g:startify_x_use_toilet = 0
endif

if !exists('g:startify_x_shortcut_length')
  let g:startify_x_shortcut_length = 2
endif

" Returns the vim version string
function! startify_x#get_vim_version() " {{{
  redir => test
    silent version
  redir END

  let line = split(test, '\n')[0]

  " Remove the part tha says (2019 Dec 12, compiled ..>)
  let line = substitute(line, ' (.*)$', '', 'g')

  return '───  ' . line
endfunction " }}}

" Sets Startify's custom header/footer
function! startify_x#set_banner() " {{{
  let project_dir = fnamemodify(getcwd(), ':t')

  if executable('toilet') && exists('g:startify_x_use_toilet') && g:startify_x_use_toilet == 1
    let g:startify_custom_header = startify_x#draw_header_with_toilet(project_dir)
  else
    let g:startify_custom_header = startify_x#draw_header(project_dir)
  endif

  let g:startify_custom_footer =
    \ startify#pad([ startify_x#get_vim_version() ])
endfunction " }}}

" Draws the header with Vimscript
function! startify_x#draw_header(str) " {{{
  return
    \ [ '' ] +
    \ startify#pad([
    \ '┏' . repeat('━', strlen(a:str) + 4) . '┓',
    \ '┃  ' . a:str . '  ┃',
    \ '┗' . repeat('━', strlen(a:str) + 4) . '┛'
    \ ]) +
    \ [ '' ]
endfunction " }}}

" Draws the header with Toilet
function! startify_x#draw_header_with_toilet(str) " {{{
  return
    \ [ '' ] +
    \ startify#pad(split(system('echo '.str.' | toilet -f future'), '\n')) +
    \ [ '' ]
endfunction " }}}

" Generates a banner from an dir path
function! startify_x#to_banner(dirpath)
  let basename = fnamemodify(a:dirpath, ':t')
  let abspath = resolve(expand(a:dirpath))
  let len = g:startify_x_shortcut_length - 1
  let shortcut = tolower(substitute(basename[0:len], '[^a-zA-Z0-9]', '', 'g'))
  return { shortcut: [ basename, 'lcd ' . abspath . ' | StartifySetBanner | Startify' ] }
endfunction


" vim:fdm=marker
