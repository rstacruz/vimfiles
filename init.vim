set t_Co=256
set nocompatible
let g:mapleader=" "
syntax on
filetype plugin indent on
call plug#begin('~/.vim/vendor')

" Essentials {{{
if !has('nvim') && !exists('g:gui_oni') | Plug 'tpope/vim-sensible' | endif

" Stop here if we're in minimal (Git) mode {{{
if $VIM_MINIMAL != '' || $GIT_AUTHOR_DATE != ''
  call plug#end()
endif
" }}}

" if !exists('g:gui_oni') | Plug 'justincampbell/vim-eighties' | endif
if version >= 704 && has('python3') | Plug 'SirVer/ultisnips' | endif
" }}}

Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'rstacruz/vim-opinion'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'irrationalistic/vim-tasks'

" Plugins: More plugins {{{
if !exists('g:gui_oni')
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'godlygeek/tabular'
  Plug 'mhinz/vim-signify'
  Plug 'rstacruz/vim-hyperstyle'
  Plug 'rstacruz/vim-xtract'
  Plug 'thinca/vim-visualstar'
endif

Plug 'liuchengxu/vim-which-key'
Plug 'shime/vim-livedown'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rstacruz/vim-closer'
Plug 'w0rp/ale'
Plug 'Galooshi/vim-import-js'
Plug 'easymotion/vim-easymotion'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh' }
if has('python3') | Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } | endif
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
" Plug 'vim-scripts/restore_view.vim'
" }}}

" Plugins: Language specific {{{
" Plug 'dag/vim-fish'
  Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }
  Plug 'elixir-editors/vim-elixir' ", { 'for': ['elixir', 'ex', 'exs'] }
" Plug 'groenewege/vim-less', { 'for': 'less' }
  Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss', 'less'] }
" Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript'] }
" Plug 'ledger/vim-ledger', { 'for': 'ledger' }
" Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
" Plug 'moll/vim-node', { 'for': 'javascript' }
  Plug 'pangloss/vim-javascript' " { 'for': 'javascript' }
  Plug 'mxw/vim-jsx' " { 'for': 'javascript' }
  Plug 'plasticboy/vim-markdown'
  Plug 'alampros/vim-styled-jsx' " { 'for': 'javascript' }
" Plug 'rstacruz/ledgerdown', { 'rtp': 'vim', 'for': 'ledger' }
" Plug 'slashmili/alchemist.vim', { 'for': ['elixir', 'ex'] }
" Plug 'slim-template/vim-slim', { 'for': ['slim'] }
" Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-haml', { 'for': 'haml' }
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
  Plug 'wavded/vim-stylus', { 'for': 'stylus' }
" Plug 'romanzolotarev/vim-journal', { 'for': 'journal' }
" Plug 'tpope/vim-cucumber', { 'for': 'ruby' }
" Plug 'jceb/vim-orgmode', { 'for': 'org' }
" }}}

call plug#end()
" vim:foldmethod=marker

" https://github.com/neovim/neovim/wiki/FAQ#nvim-shows-weird-symbols-2-q-when-changing-modes
" set guicursor=
