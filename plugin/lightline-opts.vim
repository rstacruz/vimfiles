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

function s:update_theme()
  if exists('g:GuiLoaded')
    if &background ==# 'dark'
      call s:set_theme('ayu_dark')
      " ayu_dark, tokyonight
    else
      call s:set_theme('one')
    endif
  else
    if &background ==# 'dark'
      call s:set_theme('darcula')
    else
      call s:set_theme('one')
    endif
  endif
endfunction

autocmd ColorScheme * call s:update_theme()

command! -nargs=1 LightlineTheme call s:set_theme('<args>')
