let g:mapleader=","
call plug#begin('~/.config/nvim/vendor')

" Home-made modules
Plug '~/.config/nvim/modules/dynamic-theme'
Plug '~/.config/nvim/modules/save-typos'
Plug '~/.config/nvim/modules/ctrl-c-ctrl-v'
Plug '~/.config/nvim/modules/git-grep'

" Core plugins
Plug 'rstatcruz/vim-opinion'

" Don't load the other plugins
if $GIT_AUTHOR_DATE != '' || $VIM_MINIMAL != ''
  call plug#end()
  finish
endif

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

call plug#end()
