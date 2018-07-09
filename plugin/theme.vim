"
" Common
"

command! Dark :call <SID>darktheme()
command! Light :call <SID>lighttheme()
command! Guitheme :call <SID>guitheme()

" force no background for certain things
au ColorScheme * hi Normal ctermbg=none
au ColorScheme * hi SignColumn ctermbg=none
au ColorScheme * hi FoldColumn ctermbg=none
au ColorScheme * hi LineNr ctermbg=none

function! s:darktheme()
  "let g:airline_theme='tomorrow'
  "let g:airline_theme='raven'
  set background=dark
  "color lol
  "color alduin
  color 3dglasses
endfunction

function! s:lighttheme()
  let g:airline_theme='lucius'
  let g:airline_theme='tomorrow'
  set background=light
  color lolmono
endfunction

function! s:guitheme()
  set transparency=0
  set guioptions=
  set guioptions+=g " gray menu items
  set guioptions+=m " menu bar
  set guioptions+=e " nice gui tabs
  color ir_black+
  set antialias
  let g:airline_theme='base16'
  set guifont=Iosevka\ Medium:h16 linespace=-1
endfunction

"
" Console
"

if !has("gui_running")
  set t_Co=256
  hi VertSplit cterm=none ctermbg=none
  hi NonText ctermfg=11
  hi Conceal ctermbg=none ctermfg=1
endif

"
" Macvim
"

if has("gui_running")
  Guitheme
elseif $LIGHT_MODE == '1'
  Light
else
  Dark
endif

