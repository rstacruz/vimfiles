set guicursor=
set t_Co=256
set nocompatible
let g:mapleader=","
syntax on
filetype plugin indent on
call plug#begin('~/.vim/vendor')

" Sensible {{{
if !has('nvim') && !exists('g:gui_oni')
  Plug 'tpope/vim-sensible'
endif
" }}}

" Plugins: Themes {{{
" Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
" Plug 'spf12/vim-colors'
" Plug 'chriskempson/base16-vim'
Plug 'flazz/vim-colorschemes'
" }}}

" Stop here if we're in minimal (Git) mode {{{
if $VIM_MINIMAL != '' || $GIT_AUTHOR_DATE != ''
  call plug#end()
  finish
endif
" }}}

" Plugins: Slow plugins {{{
if !exists('g:gui_oni')
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
endif
" }}}

" Plugins: Neovim-only {{{
if has('nvim') && !exists('g:gui_oni')
  Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
  Plug 'sbdchd/neoformat'
endif
" }}}

" Plugins: Unite {{{
if !exists('g:gui_oni')
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'Shougo/unite.vim'
  Plug 'tsukkee/unite-tag'
  " Plug 'tacroe/unite-mark'
  " Plug 'Shougo/unite-outline'
  Plug 'rstacruz/vim-fastunite'
endif
" }}}

" Plugins: All others {{{
if !exists('g:gui_oni')
  Plug 'craigemery/vim-autotag'
  Plug 'godlygeek/tabular'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'justincampbell/vim-eighties'
  Plug 'mhinz/vim-signify'
  Plug 'rstacruz/vim-hyperstyle'
  Plug 'rstacruz/vim-xtract'
  Plug 'thinca/vim-visualstar'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
endif
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rstacruz/vim-closer'
Plug 'rstacruz/vim-opinion'
Plug 'w0rp/ale'
" Plug 'tpope/vim-projectionist'
" }}}

" Plugins: I can live without you {{{
"
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'ConradIrwin/vim-bracketed-paste'
" Plug 'junegunn/goyo.vim'
" Plug 'mattn/emmet-vim', { 'for': ['html'] }
" Plug 'mhinz/vim-grepper'
" Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-repeat'
" Plug 'whatyouhide/vim-lengthmatters' " highlight 80+ chars
" Plug 'easymotion/vim-easymotion'
" Plug 'vim-scripts/restore_view.vim'
" }}}


" Plugins: Language specific {{{
" Plug 'dag/vim-fish'
Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }
Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'ex', 'exs'] }
" Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss', 'less'] }
" Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript'] }
" Plug 'ledger/vim-ledger', { 'for': 'ledger' }
" Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
" Plug 'moll/vim-node', { 'for': 'javascript' }
" Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Plug 'alampros/vim-styled-jsx', { 'for': 'javascript' }
" Plug 'rstacruz/ledgerdown', { 'rtp': 'vim', 'for': 'ledger' }
" Plug 'slashmili/alchemist.vim', { 'for': ['elixir', 'ex'] }
" Plug 'slim-template/vim-slim', { 'for': ['slim'] }
" Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-haml', { 'for': 'haml' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'irrationalistic/vim-tasks'
" Plug 'romanzolotarev/vim-journal', { 'for': 'journal' }
" Plug 'tpope/vim-cucumber', { 'for': 'ruby' }
" Plug 'jceb/vim-orgmode', { 'for': 'org' }
" }}}
"
" Plugins: Ultisnips {{{
if version >= 704
  Plug 'SirVer/ultisnips'
endif
" }}}

call plug#end()
" vim:foldmethod=marker
