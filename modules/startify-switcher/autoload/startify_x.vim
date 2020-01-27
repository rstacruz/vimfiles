if !exists('g:startify_x_shortcut_length')
  let g:startify_x_shortcut_length = 2
endif

if !exists('gstartify_x_icon_folder')
  let g:startify_x_icon_folder = ''
endif

if !exists('g:startify_x_icon_file')
  let g:startify_x_icon_file = ''
  " let g:startify_x_icon_file = ''
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
  if project_dir == '' | let project_dir = '/' | endif

  let g:startify_custom_header = startify_x#draw_header(project_dir)

  let g:startify_custom_footer =
    \ startify#pad(startify_x#get_footer())
endfunction " }}}

" Sets Startify's custom footer
function! startify_x#get_footer() " {{{
  let result = []

  let version_msg = startify_x#get_vim_version() 
  let result += [version_msg]

  return result
endfunction " }}}

" Draws the header with Vimscript
function! startify_x#draw_header(str) " {{{
  let branch = startify_x#git#get_branch()
  let dirty = startify_x#git#is_dirty() ? ' ·' : ''
  return
    \ startify#pad([
    \ '┏' . repeat('━', strlen(a:str) + 4) . '┓',
    \ '┃  ' . a:str . '  ┃  ' . branch . dirty,
    \ '┗' . repeat('━', strlen(a:str) + 4) . '┛',
    \ ])
endfunction " }}}

" Generates a banner from an file/dir path
" startify_x#to_banner('/path/to/project')
function! startify_x#to_banner(target) " {{{
  let isdir = isdirectory(a:target)

  let abspath = resolve(expand(a:target))
  let basename = fnamemodify(a:target, ':t')
  let len = g:startify_x_shortcut_length - 1
  let shortcut = tolower(substitute(basename[0:len], '[^a-zA-Z0-9]', '', 'g'))

  if isdir
    let label = g:startify_x_icon_folder . '  ' . basename . '/'
    let label = startify_x#add_icon(basename . '/', 'folder')
    return { shortcut: [ label, 'lcd ' . abspath . ' | StartifySetBanner | Startify' ] }
  else
    let dirname = fnamemodify(a:target, ':h')
    let label = startify_x#add_icon(basename, 'file')
    return { shortcut: [ label, 'cd ' . dirname . ' | Gcd | e ' . abspath ] }
  endif
endfunction " }}}

" Adds an icon to a label
" startify_x#add_icon('hello', 'folder')
function! startify_x#add_icon(label, icon_name) " {{{
  let icons = {
    \ 'folder': g:startify_x_icon_folder,
    \ 'file': g:startify_x_icon_file
    \ }

  let icon = icons[a:icon_name]

  if icon != ''
    return icon . '  ' . a:label
  else
    return a:label
  endif
endfunction " }}}

" vim:fdm=marker
