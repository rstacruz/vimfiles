set nocompatible
let g:mapleader=","

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}', 'extras/{}')
syntax on
filetype plugin indent on
