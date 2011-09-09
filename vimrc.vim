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
"
autocmd QuickFixCmdPost *grep* cwindow  " Open Ggrep in quickfix window
map ,gc :Gcommit<Cr>
map ,gs :Gstatus<Cr>

Bundle 'rstacruz/sparkup', {'rtp': 'vim'}
" Sparkup: HTML helper
"   <C-e>             - Expand (HTML only)
"   <C-n>             - Move to next

Bundle 'ack.vim'
" Ack: Search in project
"   :Ack              - Search
"
let g:ackhighlight=1

Bundle 'godlygeek/csapprox'
" CSApprox: Make gvim-only colorschemes work transparently in terminal vim
"
let g:CSApprox_verbose_level=0

Bundle 'godlygeek/tabular'
" Tabular: Align stuff
"   :Tabularize /=/   - Align by the given character

Bundle 'tpope/vim-endwise'
" Endwise: Wisely add 'end' in Ruby, 'endif' in Vimscript, et al

Bundle 'HTML-AutoCloseTag'
" HTML Auto Close: Make HTML work like Dreamweaver.

Bundle 'cheat.vim'
" Cheat: Cheatsheats from http://cheat.errtheblog.com.
"   :Cheat <tab>      - Open a cheat sheet
"
let g:cheats_cache=$HOME.'/.vim/cache/cheats'

Bundle 'rygwdn/ultisnips'
" UltiSnips: Tab snippets
"   <Tab>             - Expand snippet
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsDontReverseSearchPath=0

Bundle 'scrooloose/nerdtree'
" NERDTree: Project drawer
"   <F12>             - Open NERDTree
"   <F12>O            - Open NERDTree and expand all
"
let NERDTreeDirArrows=1
let NERDTreeMouseMode=2
let NERDTreeMinimalUI=1
let NERDTreeStatusline=' '
let NERDTreeWinPos='right'
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
map <F12> :NERDTree<CR>

Bundle 'tpope/vim-commentary'
" Commentary: Commenter
"   \\\               - Comment line
"   \\ap              - Comment paragraph
"   \\4j              - Comment 5 lines
"   / (in visual)     - Toggle comment
" 
map \= \\
vmap / \\

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

Bundle 'tpope/vim-surround'
" Surround: Surround text.
"   (Visual) S"       - Surround with "
"   (Visual) gS"      - Surround with " and indent
"   cs"'              - Change surrounding thing from " to '
"   cst<a>            - Change surrounding XML tag to <a>
"   ds"               - Delete surrounding "
"   dst               - Delete surrounding HTML tag
"   ysiw]             - Surround with []
"   csw]              - Surround with []
"   yss]              - Surround entire line with []
"   ySiw]             - Surround with [], but indent

Bundle 'ervandew/supertab'
" SuperTab Continued: Perform insert mode completions with Tab
"   (Insert) <Tab>    - Autocomplete

Bundle 'majutsushi/tagbar'
" Tagbar: CTags support
"   <F11>             - Opens/closes the Tagbar drawer
"
map <F11> :TagbarToggle<Cr>
imap <F11> <Esc><F11>i

Bundle 'lrvick/Conque-Shell'
" Conque Shell: Bash shell inside VIM
"   :ConqueTerm bash  - Open a shell
"
map ,cs :ConqueTermSplit bash<Cr>

Bundle 'thinca/vim-quickrun'
" Quick Run: runs the current buffer.
"    :QuickRun        - Execute the current buffer
"    :QuickRun perl   - Execute the current buffer as perl

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
Bundle 'altercation/vim-colors-solarized' 
Bundle 'molokai'
Bundle 'vydark'
Bundle 'Lucius'

" ============================================================================

" For bundles not managed by Vundle, plop them onto extras/.
let extra_paths=substitute(glob('~/.vim/extras/*'), '\n', ',', 'g')
exec 'set runtimepath+=' . extra_paths

" Test runner
"   <F10>   - Run tests
"   ,tl     - Open test log
"
map <F10> :Test<Cr>
map ,tl <C-w>n:e test.log<Cr>a<Esc>:set ft=ruby<Cr>

" ============================================================================

filetype plugin indent on
