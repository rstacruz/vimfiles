if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" Vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

" No filetype
let g:airline_section_x = ''
let g:airline_section_z = '%3p%%'
let g:airline_section_y = g:airline_symbols.linenr . '%4l ⋅%2c'
let g:airline#extensions#hunks#enabled = 0

" Themes
let g:airline_theme='solarized'
