if globpath(&rtp, "lua/scrollbar.lua") == "" | finish | endif

" █ ┃
let g:scrollbar_max_size = 12
let g:scrollbar_shape = {
  \ 'head': '█',
  \ 'body': '█',
  \ 'tail': '█',
  \ }

let g:scrollbar_highlight = {
  \ 'head': 'scrollbar',
  \ 'body': 'scrollbar',
  \ 'tail': 'scrollbar',
  \ }

hi! link scrollbar Type

augroup ScrollbarInit
  autocmd!
  autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained,BufEnter  * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end
