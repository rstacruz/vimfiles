call plug#begin('~/.config/nvim/vendor')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'rstatcruz/vim-opinion'
Plug 'sheerun/vim-polyglot'

if $GIT_AUTHOR_DATE != '' || $VIM_MINIMAL != ''
  call plug#end()
  finish
endif

call plug#end()
