if globpath(&rtp, "plugin/airline.vim") == ""
  finish
endif

let g:airline_powerline_fonts = 1
" if !exists('g:airline_symbols')
" let g:airline_symbols = {}
" endif

" Vim-powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" let g:airline_symbols.linenr = '␊'

function! AirlineInit()
  let g:airline_section_a = ''
  let g:airline_section_b = ''
  let g:airline_section_c = ''
  let g:airline_section_x = ''
  let g:airline_section_y = ''
  " let g:airline_section_gutter = ''
  let g:airline_section_z = '' " airline#section#create(['mode'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" No extensions
let g:airline_extensions = []

" let g:bufferline_show_bufnr = 0
" let g:bufferline_echo = 0
" let g:bufferline_modified = ' •'

" Shorter text
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : ' ',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ 't'  : 'TERM',
  \ }
