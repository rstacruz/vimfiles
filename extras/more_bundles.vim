" These are bundles I don't like too much.
" They will not be loaded.

Bundle 'Raimondi/delimitMate'
" DelimitMate: Auto-completion for quotes, parens, and brackets
" This must be loaded before endwise. Also, disabled curly brace matching
" because it's the most useless thing ever.
"
let delimitMate_expand_cr=1
let delimitMate_matchpairs="(:),[:],<:>"


" Kinda screws up tabbing
Bundle 'html-improved-indentation'

Bundle 'ervandew/supertab'
" SuperTab Continued: Perform insert mode completions with Tab
"   (Insert) <Tab>    - Autocomplete

Bundle 'vim-scripts/AutoComplPop'
" AutoComplPop: Automatically show the autocomplete popup
map <F11> :AcpDisable<Cr>
map <s-F11> :AcpEnable<Cr>
let g:acp_completeOption = 'menu'
" let g:acp_behaviorKeywordCommand = "\<C-n>"
