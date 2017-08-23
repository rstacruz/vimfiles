set guicursor=
set t_Co=256
set nocompatible
let g:mapleader=","
syntax on
filetype plugin indent on

call plug#begin('~/.vim/vendor')

if !has('nvim')
  Plug 'tpope/vim-sensible'
endif

" Themes
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'spf13/vim-colors'
Plug 'chriskempson/base16-vim'
" Plug 'ivan-cukic/vim-colors-penultimate'
" Plug 'whatyouhide/vim-gotham'
" Plug 'gryftir/gryffin'
" Plug 'vim-scripts/vylight'

if $VIM_MINIMAL == ''
  " Slow plugins
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  if version >= 704
    Plug 'SirVer/ultisnips'
  endif

  " Unite
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'Shougo/unite.vim'
  Plug 'tsukkee/unite-tag'
  Plug 'tacroe/unite-mark'
  Plug 'Shougo/unite-outline'
  Plug 'rstacruz/vim-fastunite'

  " ALl others
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'craigemery/vim-autotag'
  Plug 'godlygeek/tabular'
  Plug 'jceb/vim-orgmode', { 'for': 'org' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'justincampbell/vim-eighties'
  Plug 'mattn/emmet-vim', { 'for': ['html'] }
  Plug 'mhinz/vim-grepper'
  Plug 'mhinz/vim-signify'
  Plug 'mhinz/vim-startify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'rstacruz/vim-closer'
  Plug 'rstacruz/vim-hyperstyle'
  Plug 'rstacruz/vim-opinion'
  Plug 'rstacruz/vim-xtract'
  Plug 'thinca/vim-visualstar'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-cucumber', { 'for': 'ruby' }
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'whatyouhide/vim-lengthmatters'
  Plug 'w0rp/ale'
  Plug 'easymotion/vim-easymotion'
  Plug 'vim-scripts/restore_view.vim'

  " Neovim
  if has('nvim')
    Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
  endif

  " Language specific
  Plug 'dag/vim-fish'
  Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }
  Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'ex'] }
  Plug 'groenewege/vim-less', { 'for': 'less' }
  Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss', 'less'] }
  Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript'] }
  Plug 'ledger/vim-ledger', { 'for': 'ledger' }
  Plug 'mitsuhiko/vim-python-combined'
  Plug 'moll/vim-node', { 'for': 'javascript' }
  Plug 'mxw/vim-jsx', { 'for': 'javascript' }
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'rstacruz/ledgerdown', { 'rtp': 'vim', 'for': 'ledger' }
  Plug 'slashmili/alchemist.vim', { 'for': ['elixir', 'ex'] }
  Plug 'slim-template/vim-slim', { 'for': ['slim'] }
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-haml', { 'for': 'haml' }
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
  Plug 'wavded/vim-stylus', { 'for': 'stylus' }
  Plug 'romanzolotarev/vim-journal', { 'for': 'journal' }

  " Retired: Deoplete
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'mhartington/deoplete-typescript'
  " Plug 'thinca/vim-ref'
  " Plug 'carlitux/deoplete-ternjs'

  " Retired
  " Plug 'mitee/vim-gf-python'
  " Plug 'plasticboy/vim-markdown' - slow
  " Plug 'editorconfig/editorconfig-vim' - use sleuth.vim
  " (https://github.com/plasticboy/vim-markdown/issues/194)
  " Plug 'bling/vim-bufferline' - i dont care
  " Plug 'honza/vim-snippets' - too much
  " Plug 'junegunn/rainbow_parentheses.vim' - doesnt work with js anyway
  " Plug 'mmai/vim-markdown-wiki'
  " Plug 'janko-m/vim-test' - just use dispatch
  " Plug 'Shougo/vimshell.vim' - dunno
  " Plug 'mileszs/ack.vim' - use unite or :Ag
  " Plug 'ngmy/vim-rubocop'
  " Plug 'powerman/vim-plugin-AnsiEsc' - never used it
  " Plug 'rstacruz/named-media-queries' - never used it
  " Plug 'rstacruz/vim-remux' - not working so well anymore
  " Plug 'rstacruz/vim-node-import' - interferes with UltiSnips
  " Plug 'samsonw/vim-task'
  " Plug 'sjl/vitality.vim' - not needed on neovim
  " Plug 'terryma/vim-multiple-cursors' - never used it
  " Plug 'tpope/vim-dispatch'
  " Plug 'tpope/vim-projectionist' - interaction with fzf?
  " Plug 'tpope/vim-speeddating'
  " Plug 'Shougo/neomru.vim'
  " Plug 'fishbullet/deoplete-ruby'
  " Plug 'Shougo/neco-vim'
  " Plug 'ternjs/tern_for_vim'
  " Plug 'benmills/vimux'
  " Plug 'christoomey/vim-quicklink' " C-k in visual mode
  " Plug 'majkinetor/unite-cmdmatch'
  " Plug 'junegunn/limelight.vim' " :Limelight - focus on current paragraph
  " Plug 'junegunn/vader.vim' " Testing
  " Plug 'junegunn/vim-easy-align' - tabular na lang
  " Plug 'junegunn/vim-xmark', { 'do': 'make' }
  " Plug 'mattn/webapi-vim' " for vim-quicklink
endif
call plug#end()
