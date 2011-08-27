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

Bundle 'tpope/vim-haml'
" VimHAML: Support for HAML syntax

Bundle 'UltiSnips'
" UltiSnips: Tab snippets
"   <Tab>             - Expand snippet
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

Bundle 'vim-coffee-script'
" Vim CoffeeScript: Support for CoffeeScript syntax

Bundle 'tpope/vim-fugitive'
" Fugitive: Git client
"   :Gcd
"   :Gstatus
"   :G...

Bundle 'scrooloose/nerdtree'
" NERDTree: Project drawer
"   <F10>             - Open NERDTree
"   :NERDTree         - Open NERDTree
"
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
map <F10> :NERDTree<CR>

Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Sparkup: HTML helper
"   <C-e>             - Expand (HTML only)
"   <C-n>             - Move to next

Bundle 'ack.vim'
" Ack: Search in project
"   :Ack              - Search

Bundle 'vim-scripts/Color-Sampler-Pack'
" Color Sample Pack: A bunch of colors

Bundle 'Conque-Shell'
" Conque Shell: Bash shell inside VIM
"   :ConqueTerm bash  - Open a shell

Bundle 'scrooloose/nerdcommenter'
" NERD Commenter: Commenter
"   \cc               - Comment
"   \c<space>         - Toggle comment
"   / (in visual)     - Toggle comment
"
vmap / <Leader>c <Cr>

Bundle 'tpope/vim-markdown'
" Markdown: Syntax support

Bundle 'godlygeek/tabular'
" Tabular: Align stuff
"   :Tabularize /=/   - Align by the given character

Bundle 'vim-scripts/ZoomWin'
" ZoomWin: Zoom windows
"   <C-W>o            - Zoom in/out
"
map ,o <C-W>o
map ,z <C-W>o

Bundle 'javascript.vim'
" JavaScript: Better support for JavaScript

Bundle 'vim-scripts/Ambient-Color-Scheme'
" Ambient Color Scheme: Color scheme based on Ubuntu

Bundle 'wincent/Command-T'
" Command T: File opener
"   \t, or <C-t>      - Open the file opener
"
let g:CommandTMaxHeight=20
set wildignore=vendor,*.pyc,.git,logs,tmp,.sass-cache,*~
if has("ruby")
  map <C-t> <Leader>t
end

filetype plugin indent on
