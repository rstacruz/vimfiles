"
" Some of my custom shortcuts:
"
" ----
" Cscope
" ----
"  <C-]>    Jumps to definition
"  <C-\>s   Searches for symbol
"
" ----
" Tidy quickfix (error checking for HTML)
" ----
"  <F2>     Look for errors
"  <F3/F4>  Jump to prev/next error
"  <S-F3>   Show last error
"


"" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd	     	" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" }}}
" {{{ Search

set incsearch                   "is:    automatically begins searching as you type
set ignorecase                  "ic:    ignores case when pattern matching
set smartcase                   "scs:   ignores ignorecase when pattern contains uppercase characters
set hlsearch                    "hls:   highlights search results; ctrl-n or :noh to unhighlight
nmap <silent> <C-N> :silent noh<CR>

" }}}
" {{{ Programming

syntax on                       "syn:   syntax highlighting
set cindent                     "cin:   enables automatic indenting c-style
set cinoptions=(0,l1,j1         "cino:  affects the way cindent reindents lines
set showmatch                   "sm:    flashes matching brackets or parenthasis
set matchtime=3
set listchars=tab:>-,eol:$      "lcs:   makes finding tabs easier during `set list`

" }}}
" {{{ Tabs

set softtabstop=4
set tabstop=4                   "ts:    number of spaces that a tab counts for
set shiftwidth=4                "sw:    number of spaces to use for autoindent
set smarttab                    "sta:   helps with backspacing because of expandtab
set expandtab                   "et:    uses spaces instead of tab characters

" }}}
" {{{ Others

set foldmethod=manual           "fdm:   fold by the indentation by default
set nowrap

" }}}
" {{{ Macro Helpers

set lazyredraw                  "lz:    will not redraw the screen while running macros (goes faster)

" }}}
" {{{ Backups

"set backup                      "bk:    makes a backup copy of every file you write to
"set backupdir=~/tmp             "bdir:  this may not be the most secure location to store copies of all your files
set nobackup

" }}}
" {{{ HUD and Status Info

set number                      "nu:    numbers lines
set numberwidth=5               "nuw:   width of number column
set showmode                    "smd:   shows current vi mode in lower left
set showcmd                     "sc:    shows typed commands
set cmdheight=1                 "ch:    make a little more room for error messages
set scrolloff=4                 "so:    places a couple lines between the current line and the screen edge
set sidescrolloff=2             "siso:  places a couple lines between the current column and the screen edge
set laststatus=2                "ls:    makes the status bar always visible
set ttyfast                     "tf:    improves redrawing for newer computers

" }}}
" {{{ Menu completion

set wildmenu                    "wmnu:  enhanced ed command completion
set wildmode=longest:full,list:full  "wim:   helps wildmenu auto-completion

" }}}
" {{{ Console options
"
colorscheme ae-irblack
set cursorline

" }}}
" {{{ GUI options

if has("gui_running")
	set winminheight=0          "wmh:   How much of a window is to be shown when it's 'minimized'
    set guioptions-=T           "go:    No toolbar
    set guioptions-=L           "go:    No left scrollbar
    set guioptions-=r
    set fuoptions=maxvert,maxhorz  " macvim fullscreen options
   
    colorscheme ae-jellybeans
endif

" }}}
" {{{ For GVim

if has("gui_gtk2")
    set lines=60
    set columns=110
    set guifont=Liberation\ Mono\ 9
endif

" }}}
" {{{ For MacVIM

if has("gui_macvim")
    " set lines=60
    " set columns=150
    set transparency=7
    " set guioptions-=e          " No graphical tab bar
    set guifont=DroidSansMono:h12
    set linespace=2
    "set guifont=Monaco:h12
    "set guifont=Inconsolata:h14
endif

" Swap and backup files
set directory=""
set backupdir=""
set nobackup
set nowritebackup
set noswapfile

" Auto-reload vimrc when editing
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Closetag
" http://www.linux.com/archive/articles/62139
autocmd FileType html,xml,xsl,php source ~/.vim/scripts/closetag.vim

" Uhm.. stuff
"autocmd FileType html source ~/.vim/scripts/xmlfolding.vim
"autocmd FileType html source ~/.vim/scripts/html.vim
" autocmd FileType html source ~/.vim/scripts/spark.vim

" PHP folds
autocmd FileType php source ~/.vim/scripts/php.vim " Sets tab stops
autocmd FileType php silent EnablePHPFolds
" autocmd FileType php let php_folding=0

map <C-,> <C-w>

" taglist
map <F11> :TlistToggle<CR>

" NERD explorer
map <F10> :NERDTree<CR>
map <C-T> :FuzzyFinderTextMate<CR>
imap <C-T> <Esc>:FuzzyFinderTextMate<CR>
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"

" TextMate-style folding
map <F1> za
imap <F1> <Esc>za
autocmd FileType php map <C-F1> :EnablePHPFolds<CR>
    
" Misc keys
map U <Esc>:redo<CR>

set winminheight=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-_> <C-W>_

imap <C-J> <Esc><C-W>j<C-W>_
imap <C-K> <Esc><C-W>k<C-W>_
imap <C-H> <Esc><C-W>h<C-W>_
imap <C-L> <Esc><C-W>l<C-W>_
imap <C-_> <Esc><C-W>_

" Convenience shortcuts for window ops
map ,j <C-W>j
map ,k <C-W>k
map ,h <C-W>h
map ,l <C-W>l
map ,J <C-W>J
map ,K <C-W>K
map ,H <C-W>H
map ,L <C-W>L
map ,n <C-W>n
map ,q <C-W>q
map ,s <C-W>s
map ,v <C-W>v
map ,t <C-W>t
map ,b <C-W>b

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_

" Maximize current window
map ,- <C-W>_

" New split, then maximize
map ,N <C-W>n<C-W>_

" Even out all windows (tile)
" map ,? <C-W>n<C-W>H<C-W>q

" Even out all columns, then maximize all columns
map ,? <C-W>n<C-W>H<C-W>q<C-W>t<C-W>_<C-W>l<C-W>_<C-W>l<C-W>_<C-W>l<C-W>_

" Maximize -- make the Vim wondow fit the screen
map ,+ :set columns=400<cr>:set lines=300<cr><C-W>n<C-W>H<C-W>q

" Collapse (like on a sidebar)
map ,< <C-W>30<
map ,> <C-W>30>
map ,,, <C-W>30<
map ,,. <C-W>30>

imap ,/ <Esc>
imap ,. <Esc>

" Options for Sparkup
let g:sparkupArgs = '--no-last-newline --end-guide-format="/\%s" --end-guide-newline=0'

" Options for Fuzzy Finder
let g:fuzzy_ignore = 'doc/**;.git/**;log/**;tmp/**;vendor/**;public/images/**;public/system/**;solr/**;script/**;*.pyc'
let g:fuzzy_ceiling="10_000"
let g:fuzzy_matching_limit="10"
let g:fuzzy_enumerating_limit="30"

" SimpleFold
let g:ruby_simplefold_expr =
   \'\v(^\s*(def|class|module|attr_reader|attr_accessor|alias_method|' .
             \   'attr|module_function' . ')\s' .
       \ '\v^\s*(public|private|protected)>' .
   \ '|^\s*\w+attr_(reader|accessor)\s|^\s*[#%"0-9]{0,4}\s*\{\{\{[^{])' .
   \ '|^\s*[A-Z]\w+\s*\=[^=]'
let g:ruby_simplefold_prefix = '\v^\s*(#([^{]+|\{[^{]|\{\{[^{])*)?$'

" Trailing spaces
match Error /\s\+$/

" Lusty
map ,f :LustyFilesystemExplorer<CR>
map ,e :LustyFilesystemExplorer<CR>
map ,b :LustyBufferExplorer<CR>
map ,g :LustyBufferGrep<CR>
let g:LustyExplorerSuppressRubyWarning = 1
set hidden

" Typos
command! W execute 'w'
command! Wq execute 'wq'
command! WQ execute 'wq'

" Pathogen
call pathogen#runtime_append_all_bundles()
