" Commands
" Commands {{{
  "" [:] :Light -- Theme: Light theme
  "" [:] :Dark -- Theme: Dark theme
  command! Dark :call <SID>darktheme()
  command! Light :call <SID>lighttheme()
  command! ThemeOverrides :call <SID>themeoverrides()
  command! Guitheme :call <SID>guitheme()
" }}}

" Auto-apply overrides
au ColorScheme * ThemeOverrides

" Apply dark theme (:Dark)
function! s:darktheme() " {{{
  let g:airline_theme='atomic'
  set background=dark
  if exists('g:gui_oni')
    color 1989
  else
    color base16-atelierlakeside
  endif
  call s:themeoverrides()
endfunction " }}}

" Apply light theme (:Light)
function! s:lighttheme() " {{{
  call s:themeoverrides()
  set background=light
  " color LightTan
  " color lightning
  color base16-atelierlakeside
  ThemeOverrides
  AirlineTheme base16 " lucius, base16, aurora
endfunction " }}}

" Apply overrides (:ThemeOverrides)
function! s:themeoverrides() " {{{
  if &background == 'dark'
    " higher index = more intense
    let colors = {
      \ 'invis': '235',
      \ 'mute': ['239', '240'],
      \ 'highlight_bg': [ '236', '235', '233' ],
      \ 'highlight_text': ['4', '13'],
      \ 'signify': { 'add': 22, 'delete': 124, 'change': 237 },
      \ 'splitdiff': { 'add': 65, 'delete': 235, 'change': 238, 'text': 254 },
      \ 'diff': { 'removed': 161, 'added': 64, 'file': 8, 'line': 2 }
      \ }
  else
    let colors = {
      \ 'invis': '254',
      \ 'mute': ['250', '247'],
      \ 'highlight_bg': [ '254', '254', '253' ],
      \ 'highlight_text': ['4', '13'],
      \ 'signify': { 'add': 76, 'delete': 203, 'change': 250 },
      \ 'splitdiff': { 'add': 65, 'delete': 235, 'change': 238, 'text': 254 },
      \ 'diff': { 'removed': 161, 'added': 64, 'file': 8, 'line': 2 }
      \ }
  endif
  set fillchars=fold: 
  call s:themeoverrides_common()
  call s:themeoverrides_custom(colors)
endfunction " }}}

" [private] Common overrides for all occasions
function! s:themeoverrides_common() " {{{
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
  hi ErrorMsg ctermbg=none ctermfg=161 cterm=italic
  hi Error ctermbg=none ctermfg=161 cterm=none

  " Wild menu
  hi StatusLine ctermfg=1 ctermbg=none cterm=none gui=none
  hi StatusLineNC ctermfg=0 ctermbg=none

  hi! link mkdInlineURL LineNr

  hi TabLineFill ctermbg=none
endfunction " }}}

" [private] Custom overrides, depending on background
function! s:themeoverrides_custom(colors) " {{{
  let c = a:colors

  " highlights
  exec "hi Visual     ctermbg=".(c.highlight_bg[1])."  ctermfg=".(c.highlight_text[1])
  exec "hi VertSplit  ctermbg=none ctermfg=".(c.invis)." cterm=none"
  exec "hi NonText    ctermbg=none ctermfg=".(c.invis)." cterm=none"
  exec "hi Search     ctermfg=".(c.highlight_text[0])." ctermbg=".(c.highlight_bg[1])

  exec "hi CursorLine   ctermbg=".(c.highlight_bg[0])
  exec "hi CursorLineNr ctermbg=none ctermfg=".(c.highlight_text[1])

  " ale errors
  exec "hi SpellBad ctermbg=".(c.highlight_bg[0])." cterm=italic,underline ctermfg=".(c.highlight_text[1])
  exec "hi SpellBad ctermbg=".(c.highlight_bg[0])." cterm=italic ctermfg=161"

  " popup
  exec "hi Pmenu     ctermfg=".(c.highlight_text[0])." ctermbg=".(c.highlight_bg[1])
  exec "hi PmenuSel  ctermfg=".(c.highlight_text[0])." ctermbg=".(c.highlight_bg[2])

  " mutes
  exec "hi LineNr     ctermfg=".(c.mute[0])
  exec "hi Noise      ctermfg=".(c.mute[1])

  " tab line
  exec "hi TabLine    ctermbg=none ctermfg=".(c.mute[1])
  exec "hi TabLineSel ctermbg=".(c.highlight_bg[1])." ctermfg=".(c.highlight_text[1])." cterm=none"

  " green, gray, invisibleish, red, highlighted spans
  exec "hi DiffAdd    ctermfg=".(c.splitdiff.add   )." ctermbg=".(c.highlight_bg[1])
  exec "hi DiffChange ctermfg=".(c.splitdiff.change)." ctermbg=".(c.highlight_bg[1])
  exec "hi DiffDelete ctermfg=".(c.splitdiff.delete)." ctermbg=none"
  exec "hi DiffText   ctermfg=".(c.splitdiff.text  )." ctermbg=".(c.highlight_text[0])." cterm=bold"

  " single panel diffs
  exec "hi DiffRemoved ctermfg=".(c.diff.removed)." ctermbg=".(c.highlight_bg[1])
  exec "hi DiffAdded   ctermfg=".(c.diff.added  )." ctermbg=".(c.highlight_bg[1])
  exec "hi DiffNewFile ctermfg=".(c.diff.file   )." ctermbg=".(c.highlight_bg[1])
  exec "hi DiffFile    ctermfg=".(c.diff.file   )." ctermbg=".(c.highlight_bg[1])
  exec "hi DiffLine    ctermfg=".(c.diff.line   )." ctermbg=".(c.highlight_bg[1])

  exec "hi SignifySignAdd    ctermbg=none ctermfg=".(c.signify.add)
  exec "hi SignifySignDelete ctermbg=none ctermfg=".(c.signify.delete)
  exec "hi SignifySignChange ctermbg=none ctermfg=".(c.signify.change)

  exec "hi StartifyHeader ctermfg=".(c.highlight_text[1])." cterm=italic"
endfunction " }}}

" GUI theme (:GuiTheme)
function! s:guitheme() " {{{
  set transparency=0
  set guioptions=
  set guioptions+=g " gray menu items
  set guioptions+=m " menu bar
  set guioptions+=e " nice gui tabs
  color ir_black+
  set antialias
  let g:airline_theme='base16'
  set guifont=Iosevka\ Medium:h16 linespace=-1
endfunction " }}}

" vim:foldmethod=syntax
