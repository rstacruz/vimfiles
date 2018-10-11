"
" Common
"

"" [:] :Light -- Theme: Light theme
"" [:] :Dark -- Theme: Dark theme
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
  let g:airline_theme='atomic'
  set background=dark
  if exists('g:gui_oni')
    color 1989
  else
    color base16-atelierlakeside
  endif
  call s:themeoverrides()
endfunction

function! s:themeoverrides()
  hi Folded ctermbg=none ctermfg=8 cterm=none
  hi Noise ctermfg=14
  hi link jsThis StorageClass
  hi link jsGlobalObjects StorageClass
  hi link WhichKeySeperator NonText
  " hi jsObjectProp cterm=bold
  hi Comment cterm=italic

  " Always red
  hi ErrorMsg ctermbg=none ctermfg=160 cterm=italic
  hi Error ctermbg=none ctermfg=160 cterm=italic

  " Wild menu
  hi StatusLine ctermfg=1 ctermbg=none cterm=none gui=none
  hi StatusLineNC ctermfg=0

  if &background == 'dark'
    hi Visual ctermbg=233 ctermfg=13
    hi VertSplit ctermbg=none ctermfg=235 cterm=none
    hi NonText ctermbg=none ctermfg=235 cterm=none
    hi Search ctermfg=4 ctermbg=236
    hi Pmenu ctermfg=4 ctermbg=235
    hi PmenuSel ctermfg=4 ctermbg=236
    hi LineNr ctermfg=239
    hi Noise ctermfg=240

    " green, gray, invisibleish, red, highlighted spans
    hi DiffAdd ctermfg=65 ctermbg=233
    hi DiffChange ctermfg=238 ctermbg=233
    hi DiffDelete ctermfg=235 ctermbg=none
    hi DiffText ctermfg=254 ctermbg=234 cterm=bold
    hi CursorLine ctermbg=233

    " single panel diffs
    hi DiffRemoved ctermfg=160 ctermbg=233
    hi DiffAdded ctermfg=64 ctermbg=233
    hi DiffNewFile ctermfg=8 ctermbg=233
    hi DiffFile ctermfg=8 ctermbg=233
    hi DiffLine ctermfg=2 ctermbg=233

    " sign
    hi SignifySignAdd ctermbg=none ctermfg=22
    hi SignifySignDelete ctermbg=none ctermfg=124
    hi SignifySignChange ctermbg=none ctermfg=237
  else
    hi Normal ctermfg=none
    hi Visual ctermbg=254 ctermfg=13
    hi VertSplit ctermbg=none ctermfg=254 cterm=none
    hi NonText ctermbg=none ctermfg=254 cterm=none
    hi Search ctermfg=4 ctermbg=254
    hi Pmenu ctermfg=4 ctermbg=254
    hi PmenuSel ctermfg=4 ctermbg=253
    hi CursorLine ctermbg=254

    hi DiffAdd ctermfg=65 ctermbg=254
    hi DiffChange ctermfg=238 ctermbg=254
    hi DiffDelete ctermfg=235 ctermbg=none
    hi DiffText ctermfg=234 ctermbg=254 cterm=bold

    " single panel diffs
    hi DiffRemoved ctermfg=160 ctermbg=254
    hi DiffAdded ctermfg=64 ctermbg=254
    hi DiffNewFile ctermfg=8 ctermbg=254
    hi DiffFile ctermfg=8 ctermbg=254
    hi DiffLine ctermfg=2 ctermbg=254

    hi SignifySignAdd ctermbg=none ctermfg=76
    hi SignifySignDelete ctermbg=none ctermfg=203
    hi SignifySignChange ctermbg=none ctermfg=250
  endif
  set fillchars=fold: 
endfunction

function! s:lighttheme()
  let g:airline_theme='lucius'
  let g:airline_theme='aurora'
  call s:themeoverrides()
  set background=light
  " color LightTan
  " color lightning
  color base16-atelierlakeside
  ThemeOverrides
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
endif
