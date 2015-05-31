set t_Co=256
set nocompatible
let g:mapleader=","
syntax on
filetype plugin indent on

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'

" Themes
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'spf13/vim-colors'
Plug 'whatyouhide/vim-gotham'

if $VIM_MINIMAL == ''
  " Slow plugins
  Plug 'scrooloose/nerdtree'
  Plug 'bling/vim-airline'
  Plug 'SirVer/ultisnips'
  " Plug 'Shougo/vimshell.vim'
  " Plug 'rstacruz/vim-ultisnips-css' retired :)

  " Unite
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'Shougo/unite.vim'
  Plug 'tsukkee/unite-tag'
  Plug 'tacroe/unite-mark'
  Plug 'Shougo/unite-outline'
  Plug 'Shougo/neomru.vim'
  Plug 'rstacruz/vim-fastunite'

  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'craigemery/vim-autotag'
  Plug 'godlygeek/tabular'
  Plug 'honza/vim-snippets'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/vader.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/vim-xmark', { 'do': 'make' }
  Plug 'justincampbell/vim-eighties'
  Plug 'mattn/emmet-vim'
  Plug 'mhinz/vim-signify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'mileszs/ack.vim'
  Plug 'rstacruz/named-media-queries'
  Plug 'rstacruz/vim-hyperstyle'
  Plug 'rstacruz/vim-opinion'
  Plug 'scrooloose/syntastic'
  Plug 'sjl/vitality.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'thinca/vim-visualstar'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-pathogen'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'whatyouhide/vim-lengthmatters'

  " Plug 'rstacruz/sparkup', { 'rtp': 'vim' }
  " Plug 'roman/golden-ratio'
  " Plug 'jiangmiao/auto-pairs'
  " I don't really like this becaus when you have:
  "     x = |foo
  " And you want to quote foo, another ' gets inserted:
  "     x = '|'foo

  " Not working well with nvim
  if !has('nvim')
  Plug 'markwu/ZoomWin'
  endif

  " Language specific
  Plug 'wavded/vim-stylus', { 'for': 'stylus' }
  Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
  Plug 'tpope/vim-rails'
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss', 'less'] }
  Plug 'groenewege/vim-less', { 'for': 'less' }
  Plug 'rstacruz/ledgerdown', { 'rtp': 'vim' }
  Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript'] }
  Plug 'tpope/vim-haml'
  Plug 'ledger/vim-ledger'
  Plug 'moll/vim-node'
  Plug 'dag/vim-fish'
  Plug 'mitsuhiko/vim-python-combined'

  " Disabled
  " Plug 'mitee/vim-gf-python'
  " Plug 'editorconfig/editorconfig-vim' - use sleuth.vim
  " Plug 'plasticboy/vim-markdown' - not even working
  " (https://github.com/plasticboy/vim-markdown/issues/194)
  " Plug 'bling/vim-bufferline' - i dont care
  " mmai/vim-markdown-wiki 
endif
call plug#end()
