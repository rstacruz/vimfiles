" ╻ ╻  ╻  ┏┳┓
" ┃┏┛  ┃  ┃┃┃
" ┗┛   ╹  ╹ ╹

let g:maplocalleader="<Space>"
let g:mapleader=","

if has('nvim')
  let vim = stdpath('config')
else
  let vim = $HOME . '/.vim'
end

call plug#begin(vim . '/vendor')

" Language plugins {{{
let g:polyglot_disabled = ['markdown']
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'
Plug 'alampros/vim-styled-jsx'
" }}}

" Don't load the other plugins for git commit
if $GIT_EXEC_PATH != '' | call plug#end() | finish | endif

" Home-made modules {{{
Plug vim . '/modules/auto-cursorline'
Plug vim . '/modules/ctrl-c-ctrl-v'
Plug vim . '/modules/dynamic-theme'
Plug vim . '/modules/lolcolor'
Plug vim . '/modules/jk-on-wrap'
Plug vim . '/modules/quickterm'
Plug vim . '/modules/save-typos'
Plug vim . '/modules/startify-switcher'
Plug vim . '/modules/synstack'
" }}}

" Plugins available in minimal mode {{{
Plug 'cweagans/vim-taskpaper'
Plug 'preservim/nerdtree'
Plug 'rstacruz/vim-opinion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive' " git extensions
Plug 'tpope/vim-rhubarb' " enable :Gbrowse for Git
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired' " 'yon' to toggle line numbers, and more
Plug 'rstacruz/vim-gitgrep'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
" }}}

" Don't load the other plugins
if $VIM_MINIMAL != '' | call plug#end() | finish | endif

" Most plugins {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-dispatch'
Plug 'rstacruz/vim-closer'
Plug 'junegunn/gv.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathangrigg/vim-beancount'
Plug 'thinca/vim-visualstar'
Plug 'wellle/context.vim'
Plug 'jrudess/vim-foldtext'
Plug 'airblade/vim-gitgutter'
Plug 'rstacruz/vim-xtract'
Plug 'ferrine/md-img-paste.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
" }}}

" Requires nvim {{{
if has('nvim')
  Plug 'voldikss/vim-floaterm'
endif

" Requires nvim 0.5 or later
if has('nvim-0.5')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
" }}}

" GUI themes and colorschemes {{{
Plug 'challenger-deep-theme/vim'
Plug 'cocopon/iceberg.vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'equt/paper.vim'
Plug 'ghifarit53/daycula-vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'lifepillar/vim-colortemplate'
" }}}

" Coc extensions {{{
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-solargraph',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-emmet',
  \ 'coc-ultisnips',
  \ ]
" Coc extensions }}}

" Bye
" vim:foldmethod=marker
call plug#end()
