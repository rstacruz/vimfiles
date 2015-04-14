" set term=xterm-256color
set t_Co=256
set nocompatible
let g:mapleader=","

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}', 'bundle/{}/vim', 'extras/{}')
syntax on
filetype plugin indent on

