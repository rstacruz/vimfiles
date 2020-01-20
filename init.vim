let g:mapleader=","
call plug#begin('~/.config/nvim/vendor')
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'rstatcruz/vim-opinion'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}

" Home-made modules
Plug '~/.config/nvim/modules/dynamic-theme'
Plug '~/.config/nvim/modules/save-typos'
Plug '~/.config/nvim/modules/ctrl-c-ctrl-v'

if $GIT_AUTHOR_DATE != '' || $VIM_MINIMAL != ''
  call plug#end()
  finish
endif

call plug#end()
