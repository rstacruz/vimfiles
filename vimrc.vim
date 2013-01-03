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

Bundle 'gmarik/vundle'
" Vundler: Bundle organizer
"  :BundleList          - list configured bundles
"  :BundleInstall(!)    - install(update) bundles
"  :BundleSearch(!) foo - search(or refresh cache first) for foo
"  :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" ============================================================================

Bundle 'godlygeek/csapprox'
" CSApprox: Make gvim-only colorschemes work transparently in terminal vim
" This is a very slow plugin, so only enable (uncomment) it if you plan on
" switching color schemes.
"
let g:CSApprox_verbose_level=0

" == Bundles =================================================================

Bundle 'Lokaltog/vim-powerline'
" Powerline: cool status lines
if has("gui_running") && has("gui_macvim")
  let g:Powerline_symbols='fancy'
endif

let g:Powerline_colorscheme='solarized256'
" lighter colors: let g:Powerline_colorscheme='solarized'
" To reload: :PowerlineReloadColorscheme

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

Bundle 'tjennings/git-grep-vim'
" GitGrep: Search in project
"   :GitGrep          - Search

Bundle 'vim-coffee-script'
" VimCoffeeScript: Coffee Script compilation
"   :CoffeeCompile    - Compile a snippet or file

vmap <leader>c <esc>:'<,'>:CoffeeCompile<CR>
map <leader>c :CoffeeCompile<CR>

Bundle 'godlygeek/tabular'
" Tabular: Align stuff
"   :Tabularize /=/   - Align by the given character
map ,a= :Tabularize /[=:]/<Cr>
map ,a, :Tabularize commas<Cr>
map ,a: :Tabularize css<Cr>
map ,A: :%g/.*: .*/Tabularize css<Cr>
map <F1> :noh<Cr>

Bundle 'tpope/vim-endwise'
" Endwise: Wisely add 'end' in Ruby, 'endif' in Vimscript, et al

Bundle 'ervandew/supertab'
" SuperTab Continued: Perform insert mode completions with Tab
"   (Insert) <Tab>    - Autocomplete

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

Bundle 'EasyMotion'
" EasyMotion: Jump around
"  ,mw                - Jump to word
"  ,f                 - Jump to letter
"  ,F                 - Jump to letter (from left)
"
let g:EasyMotion_leader_key = ',m'
let g:EasyMotion_mapping_f = ',f'
let g:EasyMotion_mapping_F = ',F'
let g:EasyMotion_keys = 'aeouidhtnspyfgcrlAOEUIDHTNSPYFGCRLqjkxbmwvzQJKXBMWVZ'

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

" Bundle 'majutsushi/tagbar'
" Tagbar: CTags support
"   <F11>             - Opens/closes the Tagbar drawer
"
" map <F11> :TagbarToggle<Cr>
" imap <F11> <Esc><F11>i

" Bundle 'thinca/vim-quickrun'
" Quick Run: runs the current buffer.
"    :QuickRun        - Execute the current buffer
"    :QuickRun perl   - Execute the current buffer as perl

Bundle 'corntrace/bufexplorer'
" BufExplorer: open other files in the buffer
"    \be    - Open in current panel
"    \bs    - Open in horiz split
"    \bv    - Open in vert split

Bundle 'mikewest/vimroom'
" Vim Room: Simulating a vaguely WriteRoom-like environment in Vim.
"    :VimroomToggle
"
let g:vimroom_background='black'

Bundle 'tpope/vim-abolish'
" Abolish: Search and substitute multiple variants of a word
"   crs - Coerce to snake_case
"   crm - Coerce to MixedCase
"   crc - Coerce to camelCase
"   cru - Coerce to UPPERCASE
"   %S/application/program  (works with Application, APPLICATION, ...)

" Bundle 'jeffkreeftmeijer/vim-numbertoggle'
" Number Toggle: smart absolute and relative line number toggling
"   <C-n>    - Toogle relative number mode

Bundle 'michaeljsmith/vim-indent-object'
" Indent Object: text object for indentation
"
"   vii      - Delete indentation
"   vai      - Delete indentation and the line above

Bundle 'AutoTag'
" AutoTag: Auto generate ctags file

Bundle 'scrooloose/syntastic'
" Syntastic: Auto check syntax
" :Errors - opens error window
" :SyntasticCheck - forces checking
let g:syntastic_quiet_warnings=1
let g:syntastic_check_on_open=1
let g:syntastic_ruby_exec = "~/.rbenv/versions/1.9.3-p194/bin/ruby"
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['css', 'php', 'js', 'ruby', 'vim', 'python', 'html', 'coffee'],
                           \ 'passive_filetypes': ['sass', 'scss', 'haml'] }

" Syntastic styles
if has('unix')
  let g:syntastic_error_symbol='⚠'
  let g:syntastic_style_error_symbol='>'
  let g:syntastic_warning_symbol='★'
  let g:syntastic_style_warning_symbol='>'
endif

Bundle 'embear/vim-localvimrc'
" Local Vimrc: Project-specific settings via .lvimrc files

" == Syntax bundles ==========================================================

Bundle 'tpope/vim-haml'
Bundle 'vim-coffee-script'
Bundle 'tpope/vim-markdown'
Bundle 'jade.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-scripts/jQuery'
Bundle 'Textile-for-VIM'
Bundle 'git://gist.github.com/369178.git'
" Less syntax

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

" == Color bundles ===========================================================

Bundle 'altercation/vim-colors-solarized'
Bundle 'vydark'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim'}
Bundle 'noahfrederick/Hemisu'
Bundle 'gregsexton/Muon'
Bundle 'therubymug/vim-pyte'
" Bundle 'tpope/vim-vividchalk'
" Bundle 'vim-scripts/Ambient-Color-Scheme'
" Bundle 'molokai'
" Bundle 'Lucius'

" == Slow plugins ============================================================

if $VIM_MINIMAL != '1'

  Bundle 'SirVer/ultisnips'
  " UltiSnips: Tab snippets
  "   <Tab>             - Expand snippet
  "
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsDontReverseSearchPath=0

  Bundle 'rstacruz/vim-ultisnips-css'
  " VimUltisnipsCSS: Fast CSS snippets

  Bundle 'kien/ctrlp.vim'
  " CtrlP: File opener
  map <C-t> :CtrlPTag<Cr>
  let g:ctrlp_working_path_mode='r'
  " let g:ctrlp_cmd='CtrlPMixed'

endif

" ============================================================================

filetype plugin indent on

