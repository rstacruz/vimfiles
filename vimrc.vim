set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
Plugin 'bling/vim-airline'
Plugin 'AutoTag'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'rstacruz/vim-ultisnips-css'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'michaeljsmith/vim-indent-object'

" Syntax
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'ledger/vim-ledger'
Plugin 'groenewege/vim-less'
Plugin 'kchmck/vim-coffee-script'

call vundle#end()
filetype plugin indent on
