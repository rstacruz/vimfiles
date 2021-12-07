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

" Base palette {{{
  " Normal
  hi Normal ctermfg=none ctermbg=none

  " Colours of increasing importance
  " (noise > operators > statement > constants > highlight)
  hi BaseA  ctermfg=8
  hi BaseAi ctermfg=8 cterm=italic gui=italic
  hi BaseB  ctermfg=4 cterm=italic gui=italic
  hi BaseC  ctermfg=5
  hi BaseCu ctermfg=5 cterm=underline gui=underline
  hi BaseD  ctermfg=2
  hi BaseE  ctermfg=3 cterm=bold

  " Backgrounds (cursorline > visual > menu > selection)
  hi BaseBG1 ctermbg=8
  hi BaseBG2 ctermbg=8
  hi BaseBG3 ctermbg=4 ctermfg=0
  hi BaseBG4 ctermbg=2 ctermfg=0

  " 256 color background overrides
  if s:is_dark
    hi BaseBG1 ctermbg=237
    hi BaseBG2 ctermbg=238
    hi BaseE   ctermbg=238
  else
    hi BaseBG1 ctermbg=255
    hi BaseBG2 ctermbg=253
    hi BaseE   ctermbg=230
  endif
" }}}

" Basic syntax {{{
  call s:LinkGroups({
    \ 'BaseBG1': ['CursorLine', 'TabLine', 'TabLineFill', 'StatusLineNC'],
    \ 'BaseBG2': ['Visual', 'StatusLine'],
    \ 'BaseBG3': ['Search', 'Pmenu', 'TabLineSel'],
    \ 'BaseBG4': ['PmenuSel'],
    \ 'BaseA':   ['NonText', 'VertSplit', 'EndOfBuffer', 'SignColumn',
                 \ 'FoldColumn', 'Noise', 'LineNr'],
    \ 'BaseAi':  ['Comment', 'Folded'],
    \ 'BaseB':   ['Type', 'Quote', 'Directory', 'Delimiter', 'Constant', 'Operator'],
    \ 'BaseC':   ['Statement'],
    \ 'BaseCu':  ['Underlined'],
    \ 'BaseD':   ['String'],
    \ 'BaseE':  ['Title'],
    \ 'Normal':  ['Special', 'Identifier', 'PreProc', 'Ignore', 'Error',
                 \ 'Todo', 'MoreMsg', 'ErrorMsg', 'SpecialKey'],
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
  hi! link typescriptIdentifierName      Normal " `React` in `import React from 'react'`
  hi! link typescriptLabel               Type " `hello` in `{ hello: 1234 }`
  hi! link cssPseudoClassId              Type " `:root` in `:root { ... }`
  hi! link htmlH1                        BaseE
  hi! link mkdHeading                    BaseE
  hi! link typescriptDestructureVariable BaseE " `x` in `{ x } = y`
  hi! link typescriptAliasDeclaration    BaseE " `Post` in `type Post = { ... }`
  hi! link typescriptVariableDeclaration BaseE " `user` in `const user = ...`
  hi! link typescriptInterfaceName       BaseE " `Post` in `inteface Post { ... }`
  hi! link typescriptFuncName            BaseE " `greet` in `function greet()`
  hi! link jsFuncName                    BaseE " `greet` in `function greet()`
  hi! link jsVariableDef                 BaseE " `user` in `const user = ...`
  hi! link jsDestructuringBlock          BaseE
  hi! link rubyMethodName                BaseE
  hi! link rubyModuleName                BaseE
  hi! link rubyClassName                 BaseE
  hi! link pythonClass                   BaseE
  hi! link pythonFunction                BaseE
  hi! link cUserFunction                 BaseE
  hi! link vimFunction                   BaseE " `! Hello` in `function! Hello()`
  hi! link vimHiGroup                    Normal " `Normal` in `hi Normal ctermfg=none`
" }}}

" Variations {{{
  for style in get(g:, 'microtone_variants', [])
    if style == 'less-italic' " less italic
      hi! BaseB cterm=none gui=none

    elseif style == 'no-italic' " no italic
      hi! BaseAi cterm=none gui=none
      hi! BaseB cterm=none gui=none

    elseif style == 'bg' " add a solid background
      hi! Normal ctermbg=0

    elseif style == 'no-highlight' " no background highlight on id
      hi! BaseE ctermbg=none guibg=none
    endif
  endfor
" }}
