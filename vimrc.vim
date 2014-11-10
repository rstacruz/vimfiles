set nocompatible
let g:mapleader=","

call plug#begin("~/.vim/plugged")
Plug 'vim-scripts/ZoomWin'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'tsukkee/unite-tag'
Plug 'Shougo/unite.vim'
Plug 'tpope/vim-abolish'
Plug 'bling/vim-airline'
Plug 'craigemery/vim-autotag'
Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript'] }
Plug 'tpope/vim-commentary'
Plug 'hail2u/vim-css3-syntax', { 'for': ['css'] }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'michaeljsmith/vim-indent-object'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'js'] }
Plug 'ledger/vim-ledger', { 'for': ['ledger'] }
Plug 'groenewege/vim-less', { 'for': ['less'] }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-signify'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'rstacruz/vim-ultisnips-css', { 'for': ['css', 'scss', 'sass', 'styl'] }
Plug 'tpope/vim-vinegar'
Plug 'Shougo/vimproc.vim'
Plug 'sjl/vitality.vim'
Plug 'tpope/vim-eunuch'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jtratner/vim-flavored-markdown'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'chriskempson/tomorrow-theme'
Plug 'rstacruz/sparkup', { 'for': ['html'] }
Plug 'rstacruz/vim-opinion'
Plug 'rstacruz/ledgerdown', { 'for': ['ledgerdown'] }
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-lengthmatters'
call plug#end()

filetype plugin indent on
