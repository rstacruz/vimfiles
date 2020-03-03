let g:mapleader=","
let g:maplocalleader="<Space>"
if has('nvim')
  let vim = stdpath('config')
else
  let vim = $HOME . '/.vim'
end

call plug#begin(vim . '/vendor')

" Home-made modules
Plug vim . '/modules/auto-cursorline'
Plug vim . '/modules/ctrl-c-ctrl-v'
Plug vim . '/modules/dynamic-theme'
Plug vim . '/modules/git-grep'
Plug vim . '/modules/jk-on-wrap'
Plug vim . '/modules/quickterm'
Plug vim . '/modules/save-typos'
Plug vim . '/modules/startify-switcher'
Plug vim . '/modules/synstack'

" Core plugins
Plug 'rstacruz/vim-opinion'
Plug 'freitass/todo.txt-vim'

" Don't load the other plugins
if $GIT_AUTHOR_DATE != '' || $VIM_MINIMAL != ''
  call plug#end()
  finish
endif

" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
" Plug 'junegunn/fzf.vim'
Plug 'janko/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
" Plug 'junegunn/vim-slash'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/context.vim'

if has('nvim')
  Plug 'liuchengxu/vim-clap'
endif

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-snippets',
  \ 'coc-solargraph',
  \ ]

call plug#end()
