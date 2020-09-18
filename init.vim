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

" Plugins available in minimal mode
Plug 'cweagans/vim-taskpaper'
" Plug 'freitass/todo.txt-vim'
" Plug 'preservim/nerdtree'
Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': ':UpdateRemotePlugins' }
Plug 'rstacruz/vim-opinion'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive' " git extensions
Plug 'tpope/vim-rhubarb' " enable :Gbrowse for Git
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired' " 'yon' to toggle line numbers, and more
Plug 'neoclide/coc.nvim', {'branch': 'release'}

if has('nvim')
  Plug 'liuchengxu/vim-clap'
endif

" Don't load the other plugins
if $GIT_EXEC_PATH != '' || $VIM_MINIMAL != ''
  call plug#end()
  finish
endif

Plug 'arithran/vim-delete-hidden-buffers'
" Plug 'janko/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
" Plug 'SirVer/ultisnips'
Plug 'thinca/vim-visualstar'
Plug 'wellle/context.vim'

" if has('nvim')
"   Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
" endif

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

Plug 'itchyny/lightline.vim'
Plug 'ferrine/md-img-paste.vim'
call plug#end()

" Used to use, but don't anymore:
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
" Plug 'junegunn/fzf.vim'
" Plug 'junegunn/vim-slash'

