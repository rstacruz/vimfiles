" ============================================================================
" _  _ _ _  _ ____ ____ 
" |  | | |\/| |__/ |        rstacruz's vimrc.
"  \/  | |  | |  \ |___     Also see plugin/*.vim for the initializers
"
" ============================================================================

set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" == Bundles =================================================================

Bundle 'gmarik/vundle'
" Vundler: Bundle organizer
"  :BundleList          - list configured bundles
"  :BundleInstall(!)    - install(update) bundles
"  :BundleSearch(!) foo - search(or refresh cache first) for foo
"  :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

Bundle 'tpope/vim-fugitive'
" Fugitive: Git client
"   :Gcd
"   :Gstatus
"   :G...

Bundle 'rstacruz/sparkup', {'rtp': 'vim'}
" Sparkup: HTML helper
"   <C-e>             - Expand (HTML only)
"   <C-n>             - Move to next

Bundle 'ack.vim'
" Ack: Search in project
"   :Ack              - Search

Bundle 'Conque-Shell'
" Conque Shell: Bash shell inside VIM
"   :ConqueTerm bash  - Open a shell

Bundle 'godlygeek/tabular'
" Tabular: Align stuff
"   :Tabularize /=/   - Align by the given character

Bundle 'Raimondi/delimitMate'
" DelimitMate: Auto-completion for quotes, parens, and brackets
" This must be loaded before endwise. Also, disabled curly brace matching
" because it's the most useless thing ever.
"
let delimitMate_expand_cr=1
let delimitMate_matchpairs="(:),[:],<:>"

Bundle 'tpope/vim-endwise'
" Endwise: Wisely add 'end' in Ruby, 'endif' in Vimscript, et al

Bundle 'HTML-AutoCloseTag'
" HTML Auto Close: Make HTML work like Dreamweaver.

Bundle 'cheat.vim'
" Cheat: Cheatsheats from http://cheat.errtheblog.com.
"   :Cheat <tab>      - Open a cheat sheet
"
let g:cheats_cache=$HOME.'/.vim/cache/cheats'

Bundle 'UltiSnips'
" UltiSnips: Tab snippets
"   <Tab>             - Expand snippet
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

Bundle 'scrooloose/nerdtree'
" NERDTree: Project drawer
"   <F10>             - Open NERDTree
"   :NERDTree         - Open NERDTree
"
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
map <F10> :NERDTree<CR>

Bundle 'scrooloose/nerdcommenter'
" NERD Commenter: Commenter
"   \cc               - Comment
"   \c<space>         - Toggle comment
"   / (in visual)     - Toggle comment
"
vmap / <Leader>c <Cr>

Bundle 'vim-scripts/ZoomWin'
" ZoomWin: Zoom windows
"   <C-W>o            - Zoom in/out
"
map ,o <C-W>o
map ,z <C-W>o

Bundle 'wincent/Command-T'
" Command T: File opener
"   \t, or <C-t>      - Open the file opener
"
let g:CommandTMaxHeight=20
if has("ruby")
  map <C-t> <Leader>t
end

Bundle 'EasyMotion'
" EasyMotion: Jump around
"  ,w                 - Jump to word
"  ,f                 - Jump to letter
"
let g:EasyMotion_leader_key = '<Leader>m'
map ,w <Leader>mw
map ,f <Leader>mf

" == Syntax bundles ==========================================================

Bundle 'tpope/vim-haml'
Bundle 'vim-coffee-script'
Bundle 'tpope/vim-markdown'
Bundle 'jade.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-scripts/jQuery'
Bundle 'git://gist.github.com/369178.git'
" Less syntax

" == Color bundles ===========================================================

Bundle 'vim-scripts/Color-Sampler-Pack'
Bundle 'tpope/vim-vividchalk'
Bundle 'vim-scripts/Ambient-Color-Scheme'
Bundle 'molokai'

" ============================================================================

" For bundles not managed by Vundle, plop them onto extras/.
let extra_paths=substitute(glob('~/.vim/extras/*'), '\n', ',', 'g')
exec 'set runtimepath+=' . extra_paths

" ============================================================================
filetype plugin indent on
