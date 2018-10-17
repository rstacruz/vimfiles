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
au ColorScheme * ThemeOverrides

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

function! s:themeoverrides_common()
  hi Normal ctermbg=none ctermfg=none
  hi SignColumn ctermbg=none
  hi FoldColumn ctermbg=none
  hi LineNr ctermbg=none

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
  hi StatusLineNC ctermfg=0 ctermbg=none

  hi! link mkdInlineURL LineNr

  hi TabLineFill ctermbg=none
  hi TabLine ctermbg=none ctermfg=240
  hi TabLineSel ctermbg=none ctermfg=240 cterm=bold
endfunction

function! s:themeoverrides()
  call s:themeoverrides_common()
  if &background == 'dark'
    let mute_700="239"
    let mute_800="240"
    let bg_highlight="233"

    hi Visual    ctermbg=233 ctermfg=13
    hi VertSplit ctermbg=none ctermfg=235 cterm=none
    hi NonText   ctermbg=none ctermfg=235 cterm=none
    hi Search    ctermfg=4 ctermbg=236
    hi Pmenu     ctermfg=4 ctermbg=235
    hi PmenuSel  ctermfg=4 ctermbg=236

    exec "hi LineNr     ctermfg=".mute_700
    exec "hi Noise      ctermfg=".mute_800
    exec "hi TabLine    ctermbg=none ctermfg=".mute_700
    exec "hi TabLineSel ctermbg=none ctermfg=1 ctermbg=".mute_700." cterm=bold"

    " green, gray, invisibleish, red, highlighted spans
    hi DiffAdd ctermfg=65 ctermbg=233
    hi DiffChange ctermfg=238 ctermbg=233
    hi DiffDelete ctermfg=235 ctermbg=none
    hi DiffText ctermfg=254 ctermbg=234 cterm=bold
    exec "hi CursorLine ctermbg=".bg_highlight

    " single panel diffs
    exec "hi DiffRemoved ctermfg=160 ctermbg=".bg_highlight
    exec "hi DiffAdded   ctermfg=64  ctermbg=".bg_highlight
    exec "hi DiffNewFile ctermfg=8   ctermbg=".bg_highlight
    exec "hi DiffFile    ctermfg=8   ctermbg=".bg_highlight
    exec "hi DiffLine    ctermfg=2   ctermbg=".bg_highlight

    " sign
    hi SignifySignAdd ctermbg=none ctermfg=22
    hi SignifySignDelete ctermbg=none ctermfg=124
    hi SignifySignChange ctermbg=none ctermfg=237
  else
    hi Visual ctermbg=254 ctermfg=13
    hi VertSplit ctermbg=none ctermfg=254 cterm=none
    hi NonText ctermbg=none ctermfg=254 cterm=none
    hi Search ctermfg=4 ctermbg=254
    hi Pmenu ctermfg=4 ctermbg=254
    hi PmenuSel ctermfg=4 ctermbg=253
    hi CursorLine ctermbg=254

    hi LineNr ctermfg=250
    hi Noise ctermfg=247
    hi TabLine ctermbg=none ctermfg=250
    hi TabLineSel ctermbg=none ctermfg=5 ctermbg=0 cterm=bold

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
  call s:themeoverrides()
  set background=light
  " color LightTan
  " color lightning
  color base16-atelierlakeside
  ThemeOverrides
  AirlineTheme base16 " lucius, base16, aurora
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
