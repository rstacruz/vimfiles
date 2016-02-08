set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "lol"

" Color Kit!
" Form this triad first:
"   _base1 _accent1  ("require 'active_support'" - strings)
"   _base1 _accent2  ("attr_reader :colors" - symbols/constants/numbers)
"
" Add a white:
"   _base1 _hilite1  ("def initialize" - function names)
"   _base1 _hilite2 ("class MyClass" - class names)
"   _base1 _normal  ("var list")
"
" Do statements:
"   _normal _normalb ("if (a == b)")

" Standard colors (normal, line numbers):
hi! _normal    ctermfg=none  ctermbg=none
hi! _normalb   ctermfg=240
hi! _mute      ctermfg=11 ctermbg=none

" Mute color (comments):
hi! _comm1   ctermfg=55

" Base color:
hi! _base1   ctermfg=13
hi! _base1b  ctermfg=13

" Accent colors:
hi! _accent1   ctermfg=210
hi! _accent1b  ctermfg=208

hi! _accent2   ctermfg=31
hi! _accent2b  ctermfg=30

" White-ish:
hi! _hilite1   ctermfg=255
hi! _hilite1b  ctermfg=250

hi! _hilite2   ctermfg=LightGreen

" Special colors
hi! _red       ctermfg=Red
hi! _highlight cterm=underline ctermbg=black gui=underline

"
" General colors
"

hi! link Normal     _normal
hi! link NonText    _mute
hi! link Noise      _normalb
hi! link LineNr     _mute
hi! link Ignore     _mute      " ?
hi! link Search     _highlight " search highlight
hi! link Todo       _comm1     " TODO tags
hi! link Comment    _comm1     " comments
hi! link Number     _accent2   " true, false, 99, 1
hi! link Constant   _accent2b  " symbol, nil
hi! link String     _accent1   " 'strings'
hi! link Special    _accent1b  " #{ }
hi! link PreProc    _base1     " require, include
hi! link Statement  _base1b    " class, return, ...
hi! link Function   _hilite1   " builtin functions, function names
hi! link Repeat     _hilite1   " ?
hi! link Identifier _hilite1b  " @instancevars, vim vars
hi! link Type       _hilite2   " ClassName
hi! link Cursor     _mute
hi! link Error      _red

"
" Common groups that link to default highlighting.
"

hi! link Operator       Noise " ( ) = typeof
hi! link Character      String
hi! link Boolean        Number
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
hi! link SpecialKey     LineNr
hi! link Folded         LineNr
hi! link FoldColumn     Noise

"
" Languages
"

hi! link jsFunction       PreProc
hi! link jsOperator       Operator
hi! link jsBrackets       Operator
hi! link jsFuncBraces     Operator
hi! link jsNoise          Noise
hi! link jsBraces         Operator
hi! link jsParens         Operator
hi! link jsThis           Type
hi! link jsGlobalObjects  Type
hi! link jsPrototype      Type
hi! link jsNull           Constant
hi! link jsUndefined      Constant
hi! link jsStorageClass   PreProc " var
hi! link jsFutureKeys Normal " short, long, boolean

hi! link coffeeCurly      Operator
hi! link coffeeExtendedOp Operator
hi! link coffeeObjAssign  Function
hi! link coffeeParen      Operator
hi! link coffeeBracket    Operator
hi! link coffeeBrackets   Operator

hi! link rubyBlock        Operator " class body
hi! link rubyCurlyBlockDelimiter Operator

hi! link pythonBEscape   Operator

hi! link yamlKeyValueDelimiter Operator
hi! link yamlPlainScalar String
hi! link yamlFlowStringDelimiter Operator

hi! link jsonQuote Operator
hi! link jsonBraces Operator
hi! link jsonNoise Operator " comma
hi! link jsonKeywordMatch Operator " colon
hi! link jsonKeyword Statement
hi! link jsonString String

hi! link markdownHeadingDelimiter Operator
hi! link markdownCodeDelimiter Operator
hi! link markdownCode String

hi! link htmlArg Number " attribute name
hi! link htmlTag Operator
hi! link htmlEndTag Operator
hi! link htmlLink Function

hi! link cssProp Keyword " property
hi! link cssAttr normal
hi! link cssColor normal " #fff transparent
hi! link cssValueLength normal " 30px
hi! link cssValueNumber normal " 1.6
hi! link cssUnitDecorators normal " px

hi! link sassClass Type
hi! link cssTagName Type
hi! link cssPseudoClassId Type
hi! link sassAmpersand Type
hi! link cssSelectorOp Operator " [lang='en']
hi! link cssSelectorOp2 Operator " the equal sign

hi! link cssBraces Operator
hi! link cssAttrComma Operator
hi! link sassMixinName Function
hi! link sassCssAttribute Normal
hi! link sassDefinition Operator " semicolon, but includes gradients
hi! link sassProperty Operator " colon
hi! link sassClassChar sassClass

hi! link slimWrappedAttrsDelimiter Noise " () attr wrap
hi! link slimAttrAssignment Noise " =
hi! link slimRubyOutputChar Noise " = and ==
hi! link slimInlineTagChar Noise " colon in 'li: a'
hi! link slimRubyChar Noise " -
hi! link slimIdChar slimClass " #
hi! link slimId slimClass
hi! link slimDocType Noise
