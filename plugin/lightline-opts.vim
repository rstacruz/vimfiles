let g:lightline = {}

" no tab number
let g:lightline.tab = {
    \ 'active': [ 'filename' ],
    \ 'inactive': [ 'filename' ] }

" no close button
let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ ] }

let g:lightline.active =
  \ {
  \   'left': [ [], [], ['mode'] ],
  \   'right': [
  \     [ 'filename' ], [],
  \     [ 'readonly', 'modified', 'lineinfo', 'paste' ]
  \   ]
  \ }
  " \     [ 'percent' ],

let g:lightline.inactive =
  \ {
  \   'left': [],
  \   'right': [ [ 'filename' ] ],
  \ }

let g:lightline.subseparator =
  \ { 'left': '', 'right': '' }

let g:lightline.separator =
  \ { 'left': '', 'right': '' }

let g:lightline.mode_map =
  \ {
  \   'n' : '   ',
  \   'i' : '   ',
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
  if g:colors_name == 'paper'
    call s:set_theme('paper')
  elseif g:colors_name == 'daycula'
    call s:set_theme('daycula')
  elseif g:colors_name == 'github'
    call s:set_theme('ayu_light')
  elseif exists('g:GuiLoaded') && &background ==# 'dark'
    call s:set_theme('ayu_dark')
    " ayu_dark, tokyonight
  elseif &background ==# 'dark'
    call s:set_theme('darcula')
  else
    call s:set_theme('ayu_light')
  endif
endfunction

autocmd ColorScheme * call s:update_theme()

command! -nargs=1 LightlineTheme call s:set_theme('<args>')
