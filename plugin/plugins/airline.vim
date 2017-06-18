if globpath(&rtp, "plugin/airline.vim") == ""
  finish
endif

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

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
let g:airline_symbols.linenr = '␊'

let g:airline_section_x = '' " no filetype
" let g:airline_section_z = '%3p%%' " no line number, just percent
" let g:airline_section_y = g:airline_symbols.linenr . '%4l ⋅%3c' " no utf-8[unix]
let g:airline_section_z = '' " nothing
let g:airline_section_y = '' " nothing
let g:airline#extensions#hunks#enabled = 0

" Extensions
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

" Disable branch
let g:airline#extensions#branch#enabled = 0

" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
" let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" let g:bufferline_show_bufnr = 0
" let g:bufferline_echo = 0
" let g:bufferline_modified = ' •'
let g:airline_section_c = '%t'

" Shorter text
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : '∴',
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
