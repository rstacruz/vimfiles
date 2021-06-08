let g:mapleader=","
let g:maplocalleader="<Space>"
if has('nvim')
  let vim = stdpath('config')
else
  let vim = $HOME . '/.vim'
end

call plug#begin(vim . '/vendor')
let g:polyglot_disabled = ['markdown']
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'

" Don't load the other plugins for git commit
if $GIT_EXEC_PATH != ''
  call plug#end()
  finish
endif

" Home-made modules
Plug vim . '/modules/auto-cursorline'
Plug vim . '/modules/ctrl-c-ctrl-v'
Plug vim . '/modules/dynamic-theme'
Plug vim . '/modules/jk-on-wrap'
Plug vim . '/modules/quickterm'
Plug vim . '/modules/save-typos'
Plug vim . '/modules/startify-switcher'
Plug vim . '/modules/synstack'

" Plugins available in minimal mode
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Don't load the other plugins
if $VIM_MINIMAL != ''
  call plug#end()
  finish
endif

Plug 'arithran/vim-delete-hidden-buffers'
Plug 'tpope/vim-dispatch'
Plug 'rstacruz/vim-gitgrep'
Plug 'rstacruz/vim-closer'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathangrigg/vim-beancount'
Plug 'thinca/vim-visualstar'
Plug 'wellle/context.vim'
Plug 'jrudess/vim-foldtext'
Plug 'vimwiki/vimwiki'

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
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 't9md/vim-choosewin'

" Themes for GUI vims
Plug 'ghifarit53/tokyonight-vim'
Plug 'ghifarit53/daycula-vim'
Plug 'equt/paper.vim'
call plug#end()

" Used to use, but don't anymore:
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'junegunn/vim-slash'
" Plug 'freitass/todo.txt-vim'
" Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': ':UpdateRemotePlugins' }
" ^-- has the .git/index.lock bug
" Plug 'justinmk/vim-sneak'
" ^-- dunno, just not useful
"   Plug 'liuchengxu/vim-clap'
" ^-- fzf does it as well, and doesn't colour-shift
" Plug 'janko/vim-test'
" ^-- only useful for ruby and I'd rather up-enter
" Plug 'SirVer/ultisnips'

" :MarkdownPreview opens in your browser
" <leader>mv
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" <leader>mp
Plug 'ferrine/md-img-paste.vim'
