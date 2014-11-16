if globpath(&rtp, "plugin/airline.vim") != ""
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

  " Extensions
  let g:airline#extensions#tagbar#enabled = 1
  let g:airline#extensions#syntastic#enabled = 1

  " Disable branch
  let g:airline#extensions#branch#enabled = 0

  " Tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 1
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#tabline#left_sep = '⮀ '
  let g:airline#extensions#tabline#left_alt_sep = '⮁ '

  nmap ¡ <Plug>AirlineSelectTab1
  nmap ™ <Plug>AirlineSelectTab2
  nmap £ <Plug>AirlineSelectTab3
  nmap ¢ <Plug>AirlineSelectTab4
  nmap ∞ <Plug>AirlineSelectTab5
  nmap § <Plug>AirlineSelectTab6
  nmap ¶ <Plug>AirlineSelectTab7
  nmap • <Plug>AirlineSelectTab8
  nmap ª <Plug>AirlineSelectTab9

  let g:bufferline_show_bufnr = 0
  let g:bufferline_echo = 0
  let g:bufferline_modified = ' •'
  let g:airline_section_c = '%t'
endif
