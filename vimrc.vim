set nocompatible
filetype off
let g:mapleader=","

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'sjl/vitality.vim'
Plugin 'vim-scripts/ZoomWin'

if $VIM_MINIMAL != '1'
  Plugin 'craigemery/vim-autotag'
  Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'
  Plugin 'rstacruz/vim-ultisnips-css'
  Plugin 'mhinz/vim-signify'
  Plugin 'Shougo/vimproc.vim'
  Plugin 'Shougo/unite.vim'
  Plugin 'tsukkee/unite-tag'
endif

" Syntax
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'ledger/vim-ledger'
Plugin 'groenewege/vim-less'
Plugin 'kchmck/vim-coffee-script'
Plugin 'hail2u/vim-css3-syntax'

call vundle#end()
filetype plugin indent on
