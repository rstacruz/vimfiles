set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "lol"

" Color Kit!
" Form this triad first:
"   _base_400 _accent_400  ("require 'active_support'" - strings)
"   _base_400 _accent_200  ("attr_reader :colors" - symbols/constants/numbers)
"
" Add a white:
"   _base_400 _normal_900  ("def initialize" - function names)
"   _base_400 _accent_900 ("class MyClass" - class names)
"   _base_400 _normal  ("var list")
"
" Do statements:
"   _normal _normalb ("if (a == b)")

" End of buffer
hi! _invis     ctermfg=0   ctermbg=none

hi! _normal_200 ctermfg=238  ctermbg=none  " Noise (parentheses, line nums)
hi! _normal_300 ctermfg=242  ctermbg=none  " Semi-noise
hi! _normal_400 ctermfg=none ctermbg=none  " Standard colors
hi! _normal_900 ctermfg=255  ctermbg=none  " Bold
hi! link _normal _normal_400

" [base] comments:
hi! _comment_400   ctermfg=24

" Base color (return, const, function):
hi! _base_400   ctermfg=62   " return, const, function
hi! _base_900   ctermfg=68   " if, while, for, func calls (map, filter)

" Accent/value colors (strings):
hi! _accent_400   ctermfg=35          " strings
hi! _accent_200   ctermfg=31          " true, false, nil
hi! _accent_900   ctermfg=LightGreen  " class names

" Special colors
hi! _red       ctermfg=Red
hi! _highlight cterm=underline ctermbg=black gui=underline

"
" General colors
"

hi! link Normal     _normal
hi! link NonText    _normal_200
hi! link EndOfBuffer _invis
hi! link Noise      _normal_200
hi! link LineNr     _normal_200
hi! link Ignore     _normal_200      " ?
hi! link Search     _highlight " search highlight
hi! link Todo       _comment_400     " TODO tags
hi! link Comment    _comment_400     " comments
hi! link Number     _accent_200   " true, false, 99, 1
hi! link Constant   _accent_200   " symbol, nil
hi! link String     _accent_400   " 'strings'
hi! link Special    _normal_200      " #{ }
hi! link PreProc    _base_400     " require, include
hi! link Statement  _base_400     " class, return, ...
hi! link Function   _normal_900   " builtin functions, function names
hi! link Repeat     _base_900     " if, else, while, for, ...
hi! link Identifier _normal_900   " @instancevars, vim vars
hi! link Type       _accent_900   " ClassName
hi! link Cursor     _normal_200
hi! link Error      _red
hi! link SpellBad   _red

hi! link TabLineFill _normal_200
hi! link TabLine _normal_200
hi! link TabLineSel _accent_200
hi! link Title _normal_200

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
hi! link jsObjectKey      Function
hi! link jsBrackets       Operator
hi! link jsFuncBraces     Operator
hi! link jsArrowFunction  Operator
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
hi! link jsObjectProp     _normal_300
hi! link jsFuncCall       _base_900
hi! link jsExportDefault  Statement
hi! link jsxRegion        String
hi! link xmlAttrib        Normal
hi! link xmlEqual         Noise
hi! link xmlTag           Noise
hi! link xmlEndTag        Noise
hi! link xmlTagName       Function

hi! link coffeeCurly      Operator
hi! link coffeeExtendedOp Operator
hi! link coffeeObjAssign  Function
hi! link coffeeParen      Operator
hi! link coffeeBracket    Operator
hi! link coffeeBrackets   Operator

hi! link rubySymbol       _accent_200
hi! link rubyBlock        Operator " class body
hi! link rubyCurlyBlockDelimiter Operator
hi! link rubyKeywordAsMethod _normal_300

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

hi! link markdownH1 Repeat
hi! link markdownH2 Repeat
hi! link markdownHeadingRule Operator
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

hi! link vimSep Special
hi! link vimSet Constant

hi! link elixirDocString Comment
hi! link elixirVariable Special " @moduledoc

hi! link SignifySignChange _normal_200
hi! link SignifySignAdd _accent_400
hi! link SignifySignDelete _red
