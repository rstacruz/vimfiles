set t_Co=256
set nocompatible
let g:mapleader=","
syntax on
filetype plugin indent on

call plug#begin('~/.vim/vendor')
Plug 'tpope/vim-sensible'

" Themes
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'spf13/vim-colors'
Plug 'ivan-cukic/vim-colors-penultimate'
Plug 'whatyouhide/vim-gotham'
Plug 'gryftir/gryffin'

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
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/vader.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/vim-xmark', { 'do': 'make' }
  Plug 'justincampbell/vim-eighties'
  Plug 'mattn/emmet-vim'
  Plug 'mhinz/vim-signify'
  Plug 'mhinz/vim-startify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'mileszs/ack.vim'
  Plug 'ngmy/vim-rubocop'
  Plug 'rstacruz/named-media-queries'
  Plug 'rstacruz/vim-closer'
  Plug 'rstacruz/vim-hyperstyle'
  Plug 'rstacruz/vim-opinion'
  Plug 'rstacruz/vim-remux'
  Plug 'rstacruz/vim-node-import'
  Plug 'sjl/vitality.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'thinca/vim-visualstar'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-cucumber'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-pathogen'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'whatyouhide/vim-lengthmatters'

  " colors
  Plug 'vim-scripts/vylight'

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
    Plug 'scrooloose/syntastic'
  else
    Plug 'benekastah/neomake'
  endif

  " Language specific
  Plug 'dag/vim-fish'
  Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
  Plug 'groenewege/vim-less', { 'for': 'less' }
  Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss', 'less'] }
  Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript'] }
  Plug 'ledger/vim-ledger'
  Plug 'mitsuhiko/vim-python-combined'
  Plug 'moll/vim-node'
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'rstacruz/ledgerdown', { 'rtp': 'vim' }
  Plug 'slim-template/vim-slim'
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-haml'
  Plug 'tpope/vim-rails'
  Plug 'vim-ruby/vim-ruby'
  Plug 'wavded/vim-stylus', { 'for': 'stylus' }

  " Disabled
  " Plug 'mitee/vim-gf-python'
  " Plug 'editorconfig/editorconfig-vim' - use sleuth.vim
  " Plug 'plasticboy/vim-markdown' - not even working
  " (https://github.com/plasticboy/vim-markdown/issues/194)
  " Plug 'bling/vim-bufferline' - i dont care
  " Plug 'honza/vim-snippets' - too much
  " Plug 'junegunn/rainbow_parentheses.vim' - doesnt work with js anyway
  " Plug 'mmai/vim-markdown-wiki'
endif
call plug#end()
