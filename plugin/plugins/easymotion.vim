if globpath(&rtp, "plugin/easymotion.vim") == "" | finish | endif

" Dvorak mode
" let g:EasyMotion_keys = 'aoeuidhtnspyfgcrlqjkxbmwvzAOEUIDHTNSPYFGCRLQJKXBMWVZ.'

" Base64 mode
let g:EasyMotion_keys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.'

"" [N] ,.k -- [Easymotion] jump to a line above
"" [N] ,.j -- [Easymotion] jump to a line below
"" [N] ,.f -- [Easymotion] jump to a character above
"" [N] ,.F -- [Easymotion] jump to a character below
map <Leader>. <Plug>(easymotion-prefix)

