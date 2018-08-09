"
" Common
"

command! Dark :call <SID>darktheme()
command! Light :call <SID>lighttheme()
command! ThemeOverrides :call <SID>themeoverrides()
command! Guitheme :call <SID>guitheme()

" force no background for certain things
au ColorScheme * hi Normal ctermbg=none
au ColorScheme * hi SignColumn ctermbg=none
au ColorScheme * hi FoldColumn ctermbg=none
au ColorScheme * hi LineNr ctermbg=none

function! s:darktheme()
  "let g:airline_theme='tomorrow'
  "let g:airline_theme='atomic'
  "let g:airline_theme='lucius'
  " transparent bg: zenburn
  " black bg: term
  " gray bg: alduin, angr
  let g:airline_theme='alduin'
  set background=dark
  "color lol
  "color alduin - brownish
  "color 3dglasses
  "color Black
  "color blaquemagick - good
  color base16-atelierlakeside
  call s:themeoverrides()
endfunction

function! s:themeoverrides()
  hi VertSplit ctermbg=none ctermfg=233 cterm=none
  hi NonText ctermbg=none ctermfg=233 cterm=none
  hi Folded ctermbg=none ctermfg=8 cterm=none
  hi SignifySignAdd ctermbg=none ctermfg=4
  hi SignifySignDelete ctermbg=none ctermfg=10
  hi SignifySignChange ctermbg=none ctermfg=8
  set fillchars=fold: 
endfunction

function! s:lighttheme()
  let g:airline_theme='lucius'
  let g:airline_theme='aurora'
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

