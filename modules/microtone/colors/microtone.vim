hi clear
if exists('syntax_on') | syntax reset | endif
let colors_name = 'microtone'
let s:is_dark = (&background == 'dark')

" Helper function {{{
  function! s:LinkGroups(groups)
    for item in items(a:groups) " item == ["BaseA", ["VertSplit", "LineNr", ...]]
      for hlgroup in item[1]
        exec "hi! link " . hlgroup . " " . item[0]
      endfor
    endfor
  endfunction
" }}}

" Base palette - terminal {{{
  " Normal
  hi Normal ctermfg=none ctermbg=none

  " Colours of increasing importance
  " (A noise > B keywords > C type > D constants)
  hi BaseA  ctermfg=8
  hi BaseAi ctermfg=8 cterm=italic gui=italic
  hi BaseB  ctermfg=5
  hi BaseBu ctermfg=5 cterm=underline gui=underline
  hi BaseC  ctermfg=4 cterm=italic gui=italic
  hi BaseD  ctermfg=2

  " Ranges (cursorline > visual)
  hi BaseR1 ctermbg=8
  hi BaseR2 ctermbg=8

  " Highlights (search > title > selection)
  hi BaseH1 ctermfg=3 ctermbg=0 cterm=underline
  hi BaseH2 ctermfg=3 cterm=bold
  hi BaseH3 ctermbg=5 ctermfg=232

  " 256 color background overrides
  if s:is_dark
    hi BaseR1 ctermbg=237
    hi BaseR2 ctermbg=238
    hi BaseH2 ctermbg=236
  else
    hi BaseR1 ctermbg=254
    hi BaseR2 ctermbg=253
    hi BaseH2 ctermbg=230
  endif

  hi UndercurlError gui=undercurl guisp=#ff5555 cterm=underline
  hi UndercurlInfo  gui=undercurl guisp=#33aa33 cterm=underline
" }}}

" Base palette - GUI {{{
  if s:is_dark
    " todo
    hi Normal guibg=#282838 guifg=#dadaea
  else
    hi Normal guibg=#fdfdfd guifg=#303040
    hi BaseA  guifg=#8282a0
    hi BaseAi guifg=#8282a0 gui=italic
    hi BaseB  guifg=#40405a
    hi BaseBu guifg=#60607a gui=underline
    hi BaseC  guifg=#60607a gui=italic
    hi BaseD  guifg=#7070cc gui=italic
    hi BaseR1 guibg=#ececf3
    hi BaseR2 guibg=#ead0ef
    hi BaseH1 guibg=#ead0ef
    hi BaseH2 guifg=#3030aa guibg=#daeafa
    hi BaseH3 guibg=#ead0ef
  endif
" }}}

" Basic syntax {{{
  call s:LinkGroups({
    \ 'Normal': ['Special', 'Identifier', 'PreProc', 'Ignore', 'Error',
                \ 'Todo', 'MoreMsg', 'ErrorMsg', 'SpecialKey'],
    \ 'BaseA': ['NonText', 'VertSplit', 'EndOfBuffer', 'SignColumn',
               \ 'FoldColumn', 'Noise', 'LineNr'],
    \ 'BaseAi': ['Comment', 'Folded'],
    \ 'BaseB': ['Statement'],
    \ 'BaseBu': ['Underlined'],
    \ 'BaseC': ['Type', 'Quote', 'Directory', 'Delimiter', 'Constant', 'Operator'],
    \ 'BaseD': ['String'],
    \ 'BaseR1': ['CursorLine', 'TabLine', 'TabLineFill', 'StatusLineNC', 'Pmenu'],
    \ 'BaseR2': ['Visual', 'StatusLine'],
    \ 'BaseH1': ['Search', 'MatchParen'],
    \ 'BaseH2': ['Title'],
    \ 'BaseH3': ['TabLineSel', 'PmenuSel'],
    \ })
  " Later: DiffAdd DiffChange DiffDelete DiffText Conceal SpellBad SpellCap SpellRare SpellLocal
" }}}

" Plugin syntax {{{

  hi! link TelescopeBorder               NonText
  hi! link FloatermBorder                NonText
  hi! link StartifyFile                  String
  hi! link StartifyPath                  Statement
  hi! link StartifySlash                 Statement
  hi! link StartifyHeader                Title
  hi! link mkdHeading                    Delimiter " `#` in `# Hello`
  hi! link mkdBold                       Delimiter " `*` in `**hello**`
  hi! link mkdItalic                     Delimiter " `_` in `_hello_`
  hi! link mkdListItem                   Delimiter " `-` in `- item`
  hi! link mkdCodeStart                  Delimiter " triple-backticks
  hi! link mkdCodeEnd                    Delimiter
  hi! link mkdCodeDelimiter              Delimiter
  hi! link GitSignsAdd                   Type
  hi! link GitSignsDelete                Type
  hi! link GitSignsChange                Type
  hi! link htmlBold                      String
  hi! link htmlItalic                    Type
  hi! link typescriptImport              Type " `import` and `from`
  hi! link typescriptExport              Type " `export`
  hi! link typescriptIdentifierName      Normal " `React` in `import React from 'react'`
  hi! link typescriptLabel               Type " `hello` in `{ hello: 1234 }`
  hi! link cssPseudoClassId              Type " `:root` in `:root { ... }`
  hi! link htmlH1                        BaseH2
  hi! link mkdHeading                    BaseH2
  hi! link typescriptDestructureVariable BaseH2 " `x` in `{ x } = y`
  hi! link typescriptAliasDeclaration    BaseH2 " `Post` in `type Post = { ... }`
  hi! link typescriptVariableDeclaration BaseH2 " `user` in `const user = ...`
  hi! link typescriptInterfaceName       BaseH2 " `Post` in `inteface Post { ... }`
  hi! link typescriptFuncName            BaseH2 " `greet` in `function greet()`
  hi! link jsFuncName                    BaseH2 " `greet` in `function greet()`
  hi! link jsVariableDef                 BaseH2 " `user` in `const user = ...`
  hi! link jsDestructuringBlock          BaseH2
  hi! link rubyMethodName                BaseH2
  hi! link rubyModuleName                BaseH2
  hi! link rubyClassName                 BaseH2
  hi! link pythonClass                   BaseH2
  hi! link pythonFunction                BaseH2
  hi! link cUserFunction                 BaseH2
  hi! link vimFunction                   BaseH2 " `! Hello` in `function! Hello()`
  hi! link vimHiGroup                    Normal " `Normal` in `hi Normal ctermfg=none`
  hi! link CocFadeOut                    UndercurlInfo " unused vars
  hi! link CocUnderline                  UndercurlError 
  hi! link CocErrorHighlight             UndercurlError 
  hi! link CocWarningHighlight           UndercurlInfo 
" }}}

" Variations {{{
  for style in get(g:, 'microtone_variants', [])
    if style == 'less-italic' " less italic
      hi! BaseC cterm=none gui=none

    elseif style == 'no-italic' " no italic
      hi! BaseAi cterm=none gui=none
      hi! BaseC cterm=none gui=none

    elseif style == 'bg' " add a solid background
      hi! Normal ctermbg=0

    elseif style == 'no-highlight' " no background highlight on id
      hi! BaseH2 ctermbg=none guibg=none
    endif
  endfor
" }}
