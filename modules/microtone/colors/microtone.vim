hi clear

if exists('syntax_on')
  syntax reset
endif

let colors_name = 'microtone'
let s:is_dark=(&background == 'dark')

" Helper function {{{
  function! s:LinkGroups(groups)
    for item in items(a:groups) " item == ["BaseA1", ["VertSplit", "LineNr", ...]]
      for hlgroup in item[1]
        exec "hi! link " . hlgroup . " " . item[0]
      endfor
    endfor
  endfunction
" }}}

" Base palette {{{
  " Normal, bold
  hi Normal ctermfg=none
  hi BaseBold cterm=bold

  " Gray (noise > comment)
  hi BaseA1 ctermfg=8
  hi BaseA2 ctermfg=8

  " Highlights (constants < statement < operators)
  hi BaseB1 ctermfg=2
  hi BaseC1 ctermfg=5
  hi BaseD1 ctermfg=4

  " Backgrounds (cursorline > visual > menu > selection)
  hi BaseBG1 ctermbg=8
  hi BaseBG2 ctermbg=8
  hi BaseBG3 ctermbg=4 ctermfg=0
  hi BaseBG4 ctermbg=2 ctermfg=0

  " 256 color overrides
  if s:is_dark
    hi BaseBG1 ctermbg=237
    hi BaseBG2 ctermbg=238
  else
    hi BaseBG1 ctermbg=255
    hi BaseBG2 ctermbg=253
  endif
" }}}

" Basic syntax {{{
  call s:LinkGroups({
    \ 'BaseBG1': ['CursorLine', 'TabLine', 'TabLineFill', 'StatusLineNC'],
    \ 'BaseBG2': ['Visual', 'StatusLine'],
    \ 'BaseBG3': ['Search', 'Pmenu', 'TabLineSel'],
    \ 'BaseBG4': ['PmenuSel'],
    \ 'BaseA1': ['NonText', 'VertSplit', 'EndOfBuffer', 'SignColumn', 'FoldColumn',
      \ 'Noise', 'LineNr'],
    \ 'BaseA2': ['Comment', 'Folded'],
    \ 'BaseBold': ['Title'],
    \ 'BaseB1': ['Constant'],
    \ 'BaseC1': ['Statement'],
    \ 'BaseD1': ['Type', 'Quote', 'Directory', 'Delimiter'],
    \ 'Normal': ['Special', 'Identifier', 'PreProc',
      \ 'Ignore', 'Error', 'Todo', 'MoreMsg', 'ErrorMsg', 'SpecialKey'],
    \ })
  " Later: DiffAdd DiffChange DiffDelete DiffText Conceal SpellBad SpellCap SpellRare SpellLocal
" }}}

" Plugin syntax {{{
  hi! link TelescopeBorder  NonText
  hi! link FloatermBorder   NonText
  hi! link StartifyFile     Constant
  hi! link StartifyPath     Statement
  hi! link StartifySlash    Statement
  hi! link StartifyHeader   Title
  hi! link mkdHeading       Delimiter
  hi! link mkdBold          Delimiter
  hi! link mkdItalic        Delimiter
  hi! link mkdListItem      Delimiter
  hi! link mkdCodeStart     Delimiter
  hi! link mkdCodeEnd       Delimiter
  hi! link mkdCodeDelimiter Delimiter
  hi! link GitSignsAdd      BaseD1
  hi! link GitSignsDelete   BaseD1
  hi! link GitSignsChange   BaseD1
" }}}

" Variations {{{
  for style in get(g:, 'microtone_variants', [])
    if style == 'italic' || style == 'italic1'
      " italic comments
      hi! BaseA2 cterm=italic gui=italic

    elseif style == 'italic2'
      " additional italics
      hi! BaseA2 cterm=italic gui=italic
      hi! BaseD1 cterm=italic gui=italic

    elseif style == 'bg'
      " add a solid background
      hi! Normal ctermbg=0

    elseif style == 'alt' || style == 'alt1'
      " alternate colors
      hi! BaseB1 ctermfg=5
      hi! BaseC1 ctermfg=3
      hi! BaseD1 ctermfg=6
      hi! BaseBG3 ctermbg=6 ctermfg=0
      hi! BaseBG4 ctermbg=5 ctermfg=0
    endif
  endfor
" }}}
