" == Options =================================================================

set encoding=utf-8              "enc:   character encoding
set backspace=indent,eol,start  "bs:    backspacing over insert mode
set history=50                  "hi:    keep 50 lines of command line history
set ruler                       "ru:    show the cursor position all the time
set showcmd                     "sc:    display incomplete commands
set incsearch                   "is:    do incremental searching
set hidden                      "hid:   don't care about closing modified buffers
set winminheight=0              "wmh:   allow showing windows as just status bars
set mouse=a                     "       Enable the use of a mouse
set nowrap

" == Folding =================================================================

set foldmethod=syntax           "fdm:   fold by the indentation by default
set foldnestmax=10              "fdn:   deepest fold is 10 levels
set nofoldenable                "nofen: don't fold by default
set foldlevel=1

" == Search ==================================================================

set incsearch                   "is:    automatically begins searching as you type
set ignorecase                  "ic:    ignores case when pattern matching
set smartcase                   "scs:   ignores ignorecase when pattern contains uppercase characters
set hlsearch                    "hls:   highlights search results; ctrl-n or :noh to unhighlight
set gdefault                    "gd:    Substitute all matches in a line by default

" == Programming =============================================================

syntax on                       "syn:   syntax highlighting
set cindent                     "cin:   enables automatic indenting c-style
set cinoptions=l1,j1            "cino:  affects the way cindent reindents lines
set showmatch                   "sm:    flashes matching brackets or parenthasis
set matchtime=3                 "mat:   How long to flash brackets

" == Tabs ====================================================================

set tabstop=2                   "ts:    number of spaces that a tab renders as
set shiftwidth=2                "sw:    number of spaces to use for autoindent
set softtabstop=2               "sts:   number of spaces that tabs insert
set smarttab                    "sta:   helps with backspacing because of expandtab
set expandtab                   "et:    uses spaces instead of tab characters


" == Backups =================================================================

set nobackup                    "nobk:  in this age of version control, who needs it
set nowritebackup               "nowb:  don't make a backup before overwriting
set noswapfile                  "noswf: don't litter swap files everywhere
set directory=/tmp              "dir:   directory for temp files

" == HUD and status info =====================================================

set number                      "nu:    numbers lines
set numberwidth=5               "nuw:   width of number column
set showmode                    "smd:   shows current vi mode in lower left
set showcmd                     "sc:    shows typed commands
set cmdheight=1                 "ch:    make a little more room for error messages
set scrolloff=4                 "so:    places a couple lines between the current line and the screen edge
set sidescrolloff=2             "siso:  places a couple lines between the current column and the screen edge
set laststatus=2                "ls:    makes the status bar always visible
set ttyfast                     "tf:    improves redrawing for newer computers
set lazyredraw                  "lz:    will not redraw the screen while running macros (goes faster)

" == Encryption ==============================================================

if has("cryptv")
  set cryptmethod=blowfish        "cm:    make encryption more secure
endif

" == Menu completion =========================================================

set wildmenu                    "wmnu:  enhanced ed command completion
set wildignore+=*.~             "wig:   ignore compiled objects and backups
set wig+=*.o,*.obj,*.pyc        "       compiled objects
set wig+=.sass-cache,tmp        "       temp files
set wig+=vendor,log,logs,doc    "       usual directories

"wim:   helps wildmenu auto-completion
set wildmode=longest:full,list:full

" == Spell check =============================================================

"spf:   user's dictionary for zq / zw
set spellfile=~/.vim/spell/en.utf-8.add

" == Session management ======================================================

set sessionoptions-=options     "ssop:  don't store global/local values
set sessionoptions-=folds       "ssop:  don't store folds
