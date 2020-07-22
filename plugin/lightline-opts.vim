let g:lightline = {}

let g:lightline.active =
  \ {
  \   'left': [
  \     [],
  \     [ 'readonly', 'filename' ],
  \   ],
  \   'right': [
  \     [ 'mode', 'paste' ],
  \     [],
  \     [ 'percent', 'lineinfo', 'modified' ],
  \   ]
  \ }

let g:lightline.inactive =
  \ {
  \   'left': [
  \     [],
  \     [ 'filename' ]
  \   ],
  \   'right': []
  \ }

let g:lightline.subseparator =
  \ { 'left': '·', 'right': '' }

let g:lightline.separator =
  \ { 'left': '  ', 'right': '' }

let g:lightline.mode_map =
  \ {
  \   'n' : '',
  \   'i' : 'INS',
  \   'R' : 'R',
  \   'v' : 'VIS',
  \   'V' : 'V-LINE',
  \   "\<C-v>": 'V-BLOCK',
  \   'c' : 'CMD',
  \   's' : 'SEL',
  \   'S' : 'S-LINE',
  \   "\<C-s>": 'S-BLOCK',
  \   't': 'TERM',
  \ }

function s:set_theme(theme)
  let g:lightline.colorscheme = a:theme
  if exists('*lightline#init')
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endif
endfunction

function s:set_light()
  " call s:set_theme('one')
  " call s:set_theme('PaperColor')
  call s:set_theme('one')
endfunction

function s:set_dark()
  " call s:set_theme('darcula')
  " call s:set_theme('wombat')
  " call s:set_theme('selenized_dark')
  call s:set_theme('powerlineish')
endfunction

autocmd User DynthemeLight call s:set_light()
autocmd User DynthemeDark call s:set_dark()

command! -nargs=1 LightlineTheme call s:set_theme('<args>')
