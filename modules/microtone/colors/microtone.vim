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
  hi BaseB1  ctermfg=2
  hi BaseC1  ctermfg=5
  hi BaseC1u ctermfg=5 cterm=underline gui=underline
  hi BaseD1  ctermfg=4

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
    \ 'BaseC1u': ['Underlined'],
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
  hi! link mkdHeading       Delimiter " `#` in `# Hello`
  hi! link mkdBold          Delimiter " `*` in `**hello**`
  hi! link mkdItalic        Delimiter " `_` in `_hello_`
  hi! link mkdListItem      Delimiter " `-` in `- item`
  hi! link mkdCodeStart     Delimiter " triple-backticks
  hi! link mkdCodeEnd       Delimiter
  hi! link mkdCodeDelimiter Delimiter
  hi! link GitSignsAdd      Type
  hi! link GitSignsDelete   Type
  hi! link GitSignsChange   Type
  hi! link htmlH1           Type
  hi! link htmlBold         Constant
  hi! link htmlItalic       Statement
  hi! link typescriptImport         Type " `import` and `from`
  hi! link typescriptIdentifierName Normal " `React` in `import React from 'react'`
  hi! link typescriptLabel          Type " `hello` in `{ hello: 1234 }`
  hi! link cssPseudoClassId         Type " `:root` in `:root { ... }`
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

    elseif style == 'x-mute'
      " simplified muted colours
      hi! BaseB1  ctermfg=2
      hi! BaseC1  ctermfg=4
      hi! BaseC1u ctermfg=4 cterm=underline gui=underline
      hi! BaseD1  ctermfg=4

    elseif style == 'id'
      " experimental: highlight identifiers
      if s:is_dark
        hi! BaseID ctermbg=238 ctermfg=3 cterm=bold
      else
        hi! link BaseID Title
      endif
      hi! link htmlH1 BaseID
      hi! link typescriptDestructureVariable BaseID
      hi! link typescriptAliasDeclaration BaseID
      hi! link typescriptVariableDeclaration BaseID
      hi! link typescriptInterfaceName BaseID
      hi! link typescriptFuncName BaseID
      hi! link rubyMethodName BaseID
      hi! link rubyClassName BaseID
    endif
  endfor
" }}
