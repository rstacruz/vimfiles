if globpath(&rtp, "plugin/lengthmatters.vim") == ""
  finish
endif

let g:lengthmatters_highlight_colors = 'ctermbg=black'
let g:lengthmatters_excluded = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree', 'help', 'qf', '']
