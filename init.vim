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
" }}}

" Don't load the other plugins for git commit
if $GIT_EXEC_PATH != '' | call plug#end() | finish | endif

" Home-made modules {{{
Plug vim . '/modules/autofold'
Plug vim . '/modules/auto-cursorline'
Plug vim . '/modules/ctrl-c-ctrl-v'
Plug vim . '/modules/dynamic-theme'
Plug vim . '/modules/lolcolor'
Plug vim . '/modules/jk-on-wrap'
Plug vim . '/modules/quickterm'
Plug vim . '/modules/save-typos'
Plug vim . '/modules/startify-switcher'
Plug vim . '/modules/synstack'
Plug vim . '/modules/cd-z'
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
Plug 'liuchengxu/vista.vim'
Plug 'mhinz/vim-startify'
" }}}

" Don't load the other plugins
if $VIM_MINIMAL != '' | call plug#end() | finish | endif

" Most plugins {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-dispatch'
Plug 'rstacruz/vim-closer'
Plug 'junegunn/gv.vim'
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
Plug 'dense-analysis/ale'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Asheq/close-buffers.vim'
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
Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep-theme-vim'}
Plug 'dracula/vim', {'as': 'dracula-vim'}
Plug 'cocopon/iceberg.vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'equt/paper.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'embark-theme/vim', {'as': 'embark-theme-vim'}
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
  \ 'coc-react-refactor',
  \ ]
" Coc extensions }}}

" Bye
" vim:foldmethod=marker
call plug#end()
