set t_Co=256
set nocompatible
let g:mapleader=","
syntax on
filetype plugin indent on

" https://github.com/neovim/neovim/wiki/FAQ#nvim-shows-weird-symbols-2-q-when-changing-modes
if $TMUX != '' | set guicursor= | endif

call plug#begin('~/.vim/vendor')

if !has('nvim') && !exists('g:gui_oni') | Plug 'tpope/vim-sensible' | endif
Plug 'flazz/vim-colorschemes'

if $VIM_MINIMAL != '' || $GIT_AUTHOR_DATE != ''
  call plug#end()
  finish
endif

Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'rstacruz/vim-opinion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'

if !exists('g:gui_oni')
  Plug 'scrooloose/nerdtree'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'mhinz/vim-signify'
  Plug 'rstacruz/vim-hyperstyle'
  Plug 'rstacruz/vim-xtract'
  Plug 'thinca/vim-visualstar'
endif

Plug 'bagrat/vim-buffet'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rstacruz/vim-closer'

" Plug 'Shougo/denite.nvim' " fuzzy finding?
" Plug 'Shougo/echodoc.vim' " show documentation in cmd line
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'} " mru and stuff
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting
Plug 'lambdalisue/suda.vim'

let g:polyglot_disabled = ['markdown', 'md', 'liquid']
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails', { 'for': 'ruby' }

call plug#end()
" vim:foldmethod=marker
