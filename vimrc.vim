" set term=xterm-256color
set t_Co=256
set nocompatible
let g:mapleader=","

" runtime bundle/vim-pathogen/autoload/pathogen.vim
" execute pathogen#infect('bundle/{}', 'bundle/{}/vim', 'extras/{}')
syntax on
filetype plugin indent on

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'

" " Themes
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'spf13/vim-colors'

if $VIM_MINIMAL == ''
  " Slow plugins
  Plug 'editorconfig/editorconfig-vim'
  Plug 'scrooloose/nerdtree'
  Plug 'bling/vim-airline'
  Plug 'SirVer/ultisnips'
  Plug 'rstacruz/vim-ultisnips-css'
  Plug 'Shougo/unite.vim'
  Plug 'tsukkee/unite-tag'
  Plug 'tacroe/unite-mark'

  Plug 'vim-scripts/ZoomWin'
  Plug 'godlygeek/tabular'
  Plug 'tpope/vim-abolish'
  Plug 'craigemery/vim-autotag'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-sensible'
  Plug 'mhinz/vim-signify'
  Plug 'honza/vim-snippets'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'sjl/vitality.vim'
  Plug 'tpope/vim-pathogen'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'scrooloose/syntastic'
  Plug 'rstacruz/sparkup', { 'rtp': 'vim' }
  Plug 'rstacruz/vim-opinion'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/vim-lengthmatters'
  Plug 'tpope/vim-dispatch'
  Plug 'Shougo/unite-outline'
  Plug 'thinca/vim-visualstar'
  Plug 'bling/vim-bufferline'
  Plug 'mileszs/ack.vim'

  " Language specific
  Plug 'wavded/vim-stylus', { 'for': 'stylus' }
  Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'jtratner/vim-flavored-markdown', { 'for': ['markdown', 'md', 'mkdn'] }
  Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss', 'less'] }
  Plug 'groenewege/vim-less', { 'for': 'less' }
  Plug 'rstacruz/ledgerdown', { 'rtp': 'vim' }
  Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript'] }
  Plug 'tpope/vim-haml'
  Plug 'ledger/vim-ledger'
endif
call plug#end()
