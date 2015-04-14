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
Plug 'vim-scripts/ZoomWin'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'tsukkee/unite-tag'
Plug 'Shougo/unite.vim'
Plug 'tpope/vim-abolish'
Plug 'bling/vim-airline'
Plug 'craigemery/vim-autotag'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-commentary'
Plug 'hail2u/vim-css3-syntax'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'michaeljsmith/vim-indent-object'
Plug 'pangloss/vim-javascript'
Plug 'ledger/vim-ledger'
Plug 'groenewege/vim-less'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-signify'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'rstacruz/vim-ultisnips-css'
Plug 'tpope/vim-vinegar'
Plug 'Shougo/vimproc.vim'
Plug 'sjl/vitality.vim'
Plug 'tpope/vim-pathogen'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jtratner/vim-flavored-markdown'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'rstacruz/sparkup', { 'rtp': 'vim' }
Plug 'rstacruz/vim-opinion'
Plug 'rstacruz/ledgerdown', { 'rtp': 'vim' }
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-lengthmatters'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/unite-outline'
Plug 'thinca/vim-visualstar'
Plug 'bling/vim-bufferline'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-jade'
Plug 'tacroe/unite-mark'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'spf13/vim-colors'
call plug#end()
