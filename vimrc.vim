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
Plugin 'tpope/vim-surround' " cs([
Plugin 'tpope/vim-abolish'
Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular' " :Tab/|
Plugin 'editorconfig/editorconfig-vim'
Plugin 'sjl/vitality.vim'
Plugin 'terryma/vim-multiple-cursors' " C-n(next) C-x(skip)
Plugin 'vim-scripts/ZoomWin'

" Objects
Plugin 'michaeljsmith/vim-indent-object'

" Non-essential plugins
if $VIM_MINIMAL != '1'
  Plugin 'craigemery/vim-autotag'
  Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'
  Plugin 'rstacruz/vim-ultisnips-css'
  Plugin 'mhinz/vim-signify'
  Plugin 'Shougo/vimproc.vim'
  Plugin 'Shougo/unite.vim'
  Plugin 'Shougo/unite-outline'
  Plugin 'tsukkee/unite-tag'
endif

" Syntax
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'ledger/vim-ledger'
Plugin 'groenewege/vim-less'
Plugin 'kchmck/vim-coffee-script'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'pangloss/vim-javascript'

" Graveyard
if 1 == 2
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-easytags'
  Plugin 'majutsushi/tagbar'
endif

call vundle#end()
filetype plugin indent on
