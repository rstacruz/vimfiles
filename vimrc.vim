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
let g:mapleader=" "

" Vundler: Bundle organizer --------------------------------------------------
  Bundle 'gmarik/vundle'

  "" :BundleList          - list configured bundles
  "" :BundleInstall(!)    - install(update) bundles
  "" :BundleSearch(!) foo - search(or refresh cache first) for foo
  "" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" CSApprox: Make gvim-only colorschemes work in terminal vim -----------------
  " Bundle 'godlygeek/csapprox'
  "
  " This is a very slow plugin, so only enable (uncomment) it if you plan on
  " switching color schemes.
  "
  let g:CSApprox_verbose_level=0

" EditorConfig: see editorconfig.org -----------------------------------------
  Bundle 'editorconfig/editorconfig-vim'

" Indent Object: text object for indentation ---------------------------------
  Bundle 'michaeljsmith/vim-indent-object'

  " vii  -  Delete indentation
  " vai  -  Delete indentation and the line above

" Vim Vitality: cursor changing for tmux/iTerm2 ------------------------------
  Bundle "sjl/vitality.vim"

" Endwise: Wisely add 'end', 'endif', et al ----------------------------------
  Bundle 'tpope/vim-endwise'

" TaskPaper: Taskpaper syntax file -------------------------------------------
  Bundle 'davidoc/taskpaper.vim'

  "" <leader>td - mark as done
  "" <leader>tD - archive done
  "" <leader>tP - focus
  "" <leader>t. - hide notes

  au Filetype taskpaper setl nonumber
  au Filetype taskpaper hi Title ctermfg=4
  au Filetype taskpaper hi taskpaperDoneTag ctermfg=Green ctermbg=none guifg=Green
  au Filetype taskpaper hi taskpaperCancelledTag ctermfg=Red ctermbg=none guifg=Red
  au Filetype taskpaper hi taskpaperUrl ctermfg=Blue ctermbg=none guifg=Blue
  au Filetype taskpaper hi Conceal ctermfg=2 ctermbg=none guifg=Green

" NERDTree: Project drawer ---------------------------------------------------
  " Bundle 'tpope/vinegar'
  Bundle 'scrooloose/nerdtree'

  "" <leader>nt  - open NERDTree
  "" <leader>nd  - open NERDTree drawer

  let NERDTreeDirArrows=1
  let NERDTreeMouseMode=2
  let NERDTreeMinimalUI=1
  let NERDTreeStatusline=' '
  let NERDTreeWinPos='left'
  let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
  map <leader>nd :NERDTreeToggle<CR>
  map <leader>nt :e .<CR>

" == Non-essential plugins ===================================================
if $VIM_MINIMAL != '1'

  " to start Vim in minimal mode (which starts faster), just do:
  "
  "     VIM_MINIMAL=1 vim
  "
  " Useful as an editor for Git, viewing log files, or anything that doesn't
  " need any heavy text editing.

" Unite: ---------------------------------------------------------------------
  Bundle 'Shougo/vimproc.vim'
  Bundle 'Shougo/unite.vim'
  Bundle 'Shougo/unite-outline'

  nnoremap <leader>uf :<C-u>Unite -no-split -start-insert file buffer<CR>
  nnoremap <leader>ub :<C-u>Unite -no-split -start-insert buffer<CR>
  nnoremap <leader>up :<C-u>Unite -no-split -start-insert file_rec<CR>

  nnoremap <leader>Uf :<C-u>Unite -start-insert file buffer<CR>
  nnoremap <leader>Ub :<C-u>Unite -start-insert buffer<CR>
  nnoremap <leader>Up :<C-u>Unite -start-insert file_rec<CR>

" Airline: Lightweight powerline ---------------------------------------------
  Bundle 'bling/vim-airline'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " Vim-powerline symbols
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'

  " No filetype
  let g:airline_section_x = ''
  let g:airline_section_z = '%3p%%'
  let g:airline_section_y = g:airline_symbols.linenr . '%4l ⋅%2c'
  let g:airline#extensions#hunks#enabled = 0

  " Themes
  let g:airline_theme='solarized'

" ZenRoom2: iA Writer emulator -----------------------------------------------
  Bundle 'junegunn/goyo.vim'
  Bundle 'amix/vim-zenroom2'

" Surround: Surround text ----------------------------------------------------
  Bundle 'tpope/vim-surround'

  "" (Visual) S"   - Surround with "
  "" (Visual) gS"  - Surround with " and indent
  "" cs"'          - Change surrounding thing from " to '
  "" cst<a>        - Change surrounding XML tag to <a>
  "" ds"           - Delete surrounding "
  "" dst           - Delete surrounding HTML tag
  "" ysiw]         - Surround with []
  "" csw]          - Surround with []
  "" yss]          - Surround entire line with []
  "" ySiw]         - Surround with [], but indent

" Abolish: Search and substitute multiple variants of a word -----------------
Bundle 'tpope/vim-abolish'

  " crs - Coerce to snake_case
  " crm - Coerce to MixedCase
  " crc - Coerce to camelCase
  " cru - Coerce to UPPERCASE
  " %S/application/program  (works with Application, APPLICATION, ...)

" Commentary: Commenter ------------------------------------------------------
  Bundle 'tpope/vim-commentary'

  "" \\\            -  Comment line
  "" \\ap           -  Comment paragraph
  "" \\4j           -  Comment 5 lines
  "" / (in visual)  -  Toggle comment

  map \= \\
  vmap / \\

" ZoomWin: Zoom windows ------------------------------------------------------
  Bundle 'vim-scripts/ZoomWin'

  "   <C-W>o  -  Zoom in/out

" SuperTab Continued: insert mode completions with Tab -----------------------
  Bundle 'ervandew/supertab'

  "" (Insert) <Tab>    - Autocomplete

" Tabular: Align stuff -------------------------------------------------------
  Bundle 'godlygeek/tabular'

  " :Tabularize /=/   - Align by the given character

  map ,al :Tabularize /\v^\d*\.?\d*\*?\s/l2<Cr>
  map <F1> :noh<Cr>

" Vim Multiple Cursors: Sublime-style multi cursors --------------------------
  Bundle 'terryma/vim-multiple-cursors'

" Sparkup: HTML helper -------------------------------------------------------
  Bundle 'rstacruz/sparkup', {'rtp': 'vim'}

  "" <C-e>  -  Expand sparkup (HTML only)
  "" <C-n>  -  Move to next

" VimCoffeeScript: Coffee Script compilation ---------------------------------
  Bundle 'vim-coffee-script'

  " :CoffeeCompile  - compile a snippet or file

  vmap <leader>cc <esc>:'<,'>:CoffeeCompile<CR>
  map <leader>cc :CoffeeCompile<CR>


" Signify: show VCS changed in left side --------------------------------------
  Bundle 'mhinz/vim-signify'

  let g:signify_disable_by_default     = 1
  let g:signify_sign_add               = '⚙'
  let g:signify_sign_change            = '•'
  let g:signify_sign_delete            = '❌'
  let g:signify_sign_delete_first_line = '✂'
  let g:signify_skip_filetype = { 'taskpaper': 1 }

  " Colors
  au BufNewFile,BufRead * hi SignColumn ctermbg=none
  au BufNewFile,BufRead * hi SignifySignAdd ctermbg=none ctermfg=2
  au BufNewFile,BufRead * hi SignifySignChange ctermbg=none ctermfg=6
  au BufNewFile,BufRead * hi SignifySignDelete ctermbg=none ctermfg=1

  map <leader>st :SignifyToggle<Cr>

" AutoTag: Auto generate ctags file ------------------------------------------
  Bundle 'AutoTag'

" Syntastic: Auto check syntax -----------------------------------------------
  Bundle 'scrooloose/syntastic'

  " :Errors - opens error window
  " :SyntasticCheck - forces checking

  let g:syntastic_quiet_warnings=1
  let g:syntastic_check_on_open=1
  let g:syntastic_ruby_exec = "~/.rbenv/versions/1.9.3-p194/bin/ruby"
  let g:syntastic_mode_map = { 'mode': 'active',
                             \ 'active_filetypes': ['php', 'js', 'ruby', 'vim', 'python', 'html', 'coffee'],
                             \ 'passive_filetypes': ['sass', 'scss', 'haml', 'css'] }

  " Syntastic styles
  if has('unix')
    let g:syntastic_error_symbol='⚠'
    let g:syntastic_style_error_symbol='>'
    let g:syntastic_warning_symbol='★'
    let g:syntastic_style_warning_symbol='>'
  endif

" Fugitive: Git client -------------------------------------------------------
  Bundle 'tpope/vim-fugitive'

  "" :Gcd      - cd to project folder
  "" :Gstatus  - git status
  "" :Ggrep    - perform a git grep
  "" :G...

  autocmd QuickFixCmdPost *grep* cwindow  " Open Ggrep in quickfix window

" UltiSnips: Tab snippets ----------------------------------------------------
  Bundle 'SirVer/ultisnips'

  "" <Tab>  - Expand snippet

  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsDontReverseSearchPath=0

" Vim Ultisnips CSS: Fast CSS snippets ---------------------------------------
  Bundle 'rstacruz/vim-ultisnips-css'

" CtrlP: File opener ---------------------------------------------------------
  Bundle 'kien/ctrlp.vim'

  " map <C-t> :CtrlPTag<Cr>
  map <C-b> :CtrlPBuffer<Cr>
  map <leader>pb :CtrlPBuffer<Cr>
  map <leader>pt :CtrlPTag<Cr>
  map <leader>pp :CtrlP<Cr>
  let g:ctrlp_working_path_mode='r'

" Syntax bundles -------------------------------------------------------------

  Bundle 'tpope/vim-haml'
  Bundle 'vim-coffee-script'
  Bundle 'tpope/vim-markdown'
  Bundle 'jade.vim'
  Bundle 'cakebaker/scss-syntax.vim'
  Bundle 'vim-scripts/jQuery'
  Bundle 'Textile-for-VIM'
  Bundle 'ledger/vim-ledger'
  Bundle 'hsitz/VimOrganizer'
  Bundle 'git://gist.github.com/369178.git'
  " Less syntax

endif
" ============================================================================

  " For bundles not managed by Vundle, plop them onto extras/.
  "let extra_paths=substitute(glob('~/.vim/extras/*'), '\n', ',', 'g')
  "exec 'set runtimepath+=' . extra_paths

" == Color bundles ===========================================================

  Bundle 'altercation/vim-colors-solarized'
  Bundle 'spf13/vim-colors'
  " Bundle 'vydark'
  " Bundle 'vylight'
  Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim'}
  " Bundle 'noahfrederick/Hemisu'
  " Bundle 'gregsexton/Muon'
  " Bundle 'therubymug/vim-pyte'
  " Bundle 'tpope/vim-vividchalk'
  " Bundle 'molokai'
  " Bundle 'Lucius'
  " Bundle 'chriskempson/base16-vim'

filetype plugin indent on

" https://github.com/terryma/dotfiles/blob/master/.vimrc
