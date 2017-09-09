if globpath(&rtp, "plugin/easymotion.vim") == "" | finish | endif

" Dvorak mode
" let g:EasyMotion_keys = 'aoeuidhtnspyfgcrlqjkxbmwvzAOEUIDHTNSPYFGCRLQJKXBMWVZ.'

" Base64 mode
let g:EasyMotion_keys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.'

"" [N] <leader>.k -- Easymotion: jump to a line above
"" [N] <leader>.j -- Easymotion: jump to a line below
"" [N] <leader>.f -- Easymotion: jump to a character above
"" [N] <leader>.F -- Easymotion: jump to a character below
map <Le<leader>der>. <Plug>(easymotion-prefix)

