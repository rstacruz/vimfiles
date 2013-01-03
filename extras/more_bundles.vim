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

Bundle 'ScrollColors'
" " ScrollColors: Preview many color schemes
" "
" map <silent><F3> :NEXTCOLOR<cr>
" map <silent><F2> :PREVCOLOR<cr>

Bundle 'sickill/vim-pasta'
" Vim Pasta: Indentation-aware pasting

Bundle 'mkitt/browser-refresh.vim'
" Browser Refresh: Refresh Chrome/Safari in vim
"  :RRB      - Refresh
"
" map <silent><leader>r :RRB<CR>

Bundle 'cheat.vim'
" Cheat: Cheatsheats from http://cheat.errtheblog.com.
"   :Cheat <tab>      - Open a cheat sheet
"
let g:cheats_cache=$HOME.'/.vim/cache/cheats'

Bundle 'nathanaelkane/vim-indent-guides'
" Vim Indent Guides:
"   \ig      - Toggle indent guides
"
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

if has("gui_running")
  let g:indent_guides_color_change_percent = 2
else
  let g:indent_guides_auto_colors = 0
  " autocmd VimEnter,ColorScheme * :hi IndentGuidesEven guibg=#242424 ctermbg=234
  " autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=232
endif

Bundle 'vim-scripts/Color-Sampler-Pack'

Bundle 'Shougo/neocomplcache'
" Neocomplcache: Autocomplee thingie
"   :NeoComplCacheToggle
let g:neocomplcache_enable_at_startup = 1
map ,nn :NeoComplCacheToggle<Cr>

Bundle 'HTML-AutoCloseTag'
" HTML Auto Close: Make HTML work like Dreamweaver.

