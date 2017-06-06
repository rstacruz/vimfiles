set t_Co=256
set nocompatible
let g:mapleader=","
syntax on
filetype plugin indent on

call plug#begin('~/.vim/vendor')
Plug 'tpope/vim-sensible'

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
  " Plug 'Shougo/neomru.vim'
  Plug 'rstacruz/vim-fastunite'

  " Deoplete
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'mhartington/deoplete-typescript'
  " Plug 'thinca/vim-ref'
  if has("nvim")
    Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
  endif
  " Plug 'fishbullet/deoplete-ruby'
  " Plug 'Shougo/neco-vim'
  " Plug 'carlitux/deoplete-ternjs'

  " Plug 'ternjs/tern_for_vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'benmills/vimux'
  " Plug 'christoomey/vim-quicklink' " C-k in visual mode
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'craigemery/vim-autotag'
  Plug 'godlygeek/tabular'
  Plug 'jceb/vim-orgmode'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/goyo.vim'
  " Plug 'junegunn/limelight.vim' " :Limelight - focus on current paragraph
  Plug 'junegunn/vader.vim' " Testing
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/vim-xmark', { 'do': 'make' }
  Plug 'justincampbell/vim-eighties'
  Plug 'majkinetor/unite-cmdmatch'
  Plug 'mattn/emmet-vim'
  " Plug 'mattn/webapi-vim' " for vim-quicklink
  Plug 'mhinz/vim-grepper'
  Plug 'mhinz/vim-signify'
  Plug 'mhinz/vim-startify'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'mileszs/ack.vim'
  Plug 'ngmy/vim-rubocop'
  Plug 'powerman/vim-plugin-AnsiEsc'
  Plug 'rstacruz/named-media-queries'
  Plug 'rstacruz/vim-closer'
  Plug 'rstacruz/vim-hyperstyle'
  Plug 'rstacruz/vim-opinion'
  Plug 'rstacruz/vim-remux'
  Plug 'rstacruz/vim-xtract'
  " Plug 'rstacruz/vim-node-import' - interferes with UltiSnips
  Plug 'samsonw/vim-task'
  Plug 'sjl/vitality.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'thinca/vim-visualstar'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-cucumber'
  " Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'whatyouhide/vim-lengthmatters'

  " Not working well with nvim
  if !has('nvim')
    Plug 'markwu/ZoomWin'
    Plug 'scrooloose/syntastic'
  else
    Plug 'kassio/neoterm'
    " Plug 'benekastah/neomake'
    Plug 'w0rp/ale'
  endif

  " Language specific
  Plug 'dag/vim-fish'
  Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }
  Plug 'elixir-lang/vim-elixir'
  Plug 'groenewege/vim-less', { 'for': 'less' }
  Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss', 'less'] }
  Plug 'kchmck/vim-coffee-script', { 'for': ['coffee', 'coffeescript'] }
  Plug 'ledger/vim-ledger'
  Plug 'mitsuhiko/vim-python-combined'
  Plug 'moll/vim-node'
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'rstacruz/ledgerdown', { 'rtp': 'vim' }
  Plug 'slashmili/alchemist.vim'
  Plug 'slim-template/vim-slim'
  Plug 'tpope/vim-bundler', { 'for': 'ruby' }
  Plug 'tpope/vim-haml'
  Plug 'tpope/vim-rails'
  Plug 'vim-ruby/vim-ruby'
  Plug 'wavded/vim-stylus', { 'for': 'stylus' }
  Plug 'romanzolotarev/vim-journal'

  " Retired
  " Plug 'mitee/vim-gf-python'
  " Plug 'editorconfig/editorconfig-vim' - use sleuth.vim
  " Plug 'plasticboy/vim-markdown' - not even working
  " (https://github.com/plasticboy/vim-markdown/issues/194)
  " Plug 'bling/vim-bufferline' - i dont care
  " Plug 'honza/vim-snippets' - too much
  " Plug 'junegunn/rainbow_parentheses.vim' - doesnt work with js anyway
  " Plug 'mmai/vim-markdown-wiki'
  " Plug 'janko-m/vim-test' - just use dispatch
  " Plug 'Shougo/vimshell.vim' - dunno
endif
call plug#end()
