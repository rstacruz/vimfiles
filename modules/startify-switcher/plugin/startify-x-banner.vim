" Only work if startify exists
if globpath(&rtp, "autoload/startify.vim") == "" | finish | endif

"
" Set banner
"

command! -bar -nargs=0 StartifySetBanner :call startify_x#set_banner()

"
" Reset
"

command! -bar StartifyReset :call <SID>reset()

function! s:reset()
  Gcd
  call startify_x#set_banner()
  SClose
endfunction

StartifySetBanner
