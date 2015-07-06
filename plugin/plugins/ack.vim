if globpath(&rtp, "plugin/ack.vim") == "" | finish | endif

let g:ackhighlight=1
let g:ack_use_dispatch=1

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
