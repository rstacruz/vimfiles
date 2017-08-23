if globpath(&rtp, "plugin/easymotion.vim") == "" | finish | endif

" Dvorak mode
let g:EasyMotion_keys = 'aoeuidhtnspyfgcrlqjkxbmwvz.'
let g:EasyMotion_keys = 'aoeuidhtnspyfgcrlqjkxbmwvzAOEUIDHTNSPYFGCRLQJKXBMWVZ.'

"" [N] ,.k -- [Easymotion] jump to a line above
"" [N] ,.j -- [Easymotion] jump to a line below
"" [N] ,.f -- [Easymotion] jump to a character above
"" [N] ,.F -- [Easymotion] jump to a character below
map <Leader>. <Plug>(easymotion-prefix)

