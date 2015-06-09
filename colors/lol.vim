set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "lol"

" Main colors
hi! _normal    ctermfg=none  ctermbg=none
hi! _mute      ctermfg=black ctermbg=none

" Base colors
hi! _base0   ctermfg=DarkCyan
hi! _base1   ctermfg=5
hi! _base2   ctermfg=13
hi! _base3   ctermfg=Cyan

" Accent colors
hi! _accent1 ctermfg=LightGreen
hi! _accent2 ctermfg=White
hi! _red     ctermfg=Red

hi! _highlight cterm=underline ctermbg=black gui=underline

" General colors
hi! link Normal     _normal
hi! link NonText    _mute
hi! link LineNr     _mute
hi! link Statement  _mute      " class, return, ...
hi! link Ignore     _mute      " ?
hi! link Search     _highlight " search highlight
hi! link Comment    _base0     " comments
hi! link Constant   _base1     " string, chars, bool, ...
hi! link Special    _base1     " prototype, doctags, throw
hi! link Operator   _base2     " ( ) = typeof
hi! link PreProc    _base2     " require, include
hi! link Identifier _base3     " @instancevars, vim vars
hi! link Type       _accent1   " ClassName
hi! link Function   _accent2   " builtin functions, function names
hi! link Repeat     _accent2   " ?
hi! link Cursor     _mute
hi! link Error      _red
hi! link Todo       _red

" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi! link String         Constant
hi! link Character      Constant
hi! link Number         Constant
hi! link Boolean        Constant
hi! link Float          Number
hi! link Conditional    Repeat
hi! link Label          Statement
hi! link Keyword        Statement
hi! link Exception      Statement
hi! link Include        PreProc
hi! link Define         PreProc
hi! link Macro          PreProc
hi! link PreCondit      PreProc
hi! link StorageClass   Type
hi! link Structure      Type
hi! link Typedef        Type
hi! link Tag            Special
hi! link SpecialChar    Special
hi! link Delimiter      Special
hi! link SpecialComment Special
hi! link Debug          Special
