" ╻ ╻  ╻  ┏┳┓
" ┃┏┛  ┃  ┃┃┃
" ┗┛   ╹  ╹ ╹

let g:maplocalleader=","
let g:mapleader="\<space>"

if has('nvim')
  let vim = stdpath('config')
else
  let vim = $HOME . '/.vim'
end

call plug#begin(vim . '/vendor')

" Language plugins {{{
let g:polyglot_disabled = ['markdown','autoindent']
" autoindent support is slow on crostini
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'
Plug 'rajasegar/vim-astro'
" }}}

" Requires nvim 0.5 or later
if has('nvim-0.5')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

" Don't load the other plugins for git commit
if $GIT_EXEC_PATH != '' | call plug#end() | finish | endif

" Home-made modules {{{
Plug vim . '/modules/autofold'
Plug vim . '/modules/auto-cursorline'
Plug vim . '/modules/ctrl-c-ctrl-v'
Plug vim . '/modules/dynamic-theme'
Plug vim . '/modules/lolcolor'
Plug vim . '/modules/jk-on-wrap'
Plug vim . '/modules/quickterm'
Plug vim . '/modules/save-typos'
Plug vim . '/modules/startify-switcher'
Plug vim . '/modules/synstack'
Plug vim . '/modules/cd-z'
" }}}

" Plugins available in minimal mode {{{
Plug 'cweagans/vim-taskpaper'
Plug 'preservim/nerdtree'
Plug 'rstacruz/vim-opinion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive' " git extensions
Plug 'tpope/vim-rhubarb' " enable :Gbrowse for Git
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired' " 'yon' to toggle line numbers, and more
Plug 'rstacruz/vim-gitgrep'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vim-which-key'
Plug 'liuchengxu/vista.vim'
Plug 'mhinz/vim-startify'
" }}}

" Don't load the other plugins
if $VIM_MINIMAL != '' | call plug#end() | finish | endif

" Most plugins {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-dispatch'
Plug 'rstacruz/todo.txt-vim'
Plug 'rstacruz/vim-closer'
Plug 'junegunn/gv.vim'
Plug 'nathangrigg/vim-beancount'
Plug 'thinca/vim-visualstar'
Plug 'wellle/context.vim'
Plug 'jrudess/vim-foldtext'
Plug 'airblade/vim-gitgutter'
Plug 'rstacruz/vim-xtract'
Plug 'ferrine/md-img-paste.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Asheq/close-buffers.vim'
" }}}

" Requires nvim {{{
if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'alvarosevilla95/luatab.nvim'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'voldikss/vim-floaterm'
else
  Plug 'itchyny/lightline.vim'
endif
" }}}

" GUI themes and colorschemes {{{
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep-theme-vim'}
Plug 'cocopon/iceberg.vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'dracula/vim', {'as': 'dracula-vim'}
Plug 'drewtempelmeyer/palenight.vim'
Plug 'embark-theme/vim', {'as': 'embark-theme-vim'}
Plug 'equt/paper.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-colortemplate'
Plug 'mcchrish/zenbones.nvim'
Plug 'owickstrom/vim-colors-paramount'
" }}}

" Coc extensions {{{
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-solargraph',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-emmet',
  \ 'coc-ultisnips',
  \ 'coc-react-refactor',
  \ ]
" Coc extensions }}}

" Bye
" vim:foldmethod=marker
call plug#end()

if has('nvim-0.5')
lua << EOF
  -- require('tabline').setup {
  --   enable = false,
  --   options = {
  --     section_separators = {'│', '│'},
  --     component_separators = {'', ''},
  --     show_tabs_always = true,
  --     show_filename_only = true
  --   }
  -- }
  vim.o.tabline = '%!v:lua.require\'luatab\'.tabline()'
  require('lualine').setup {
    options = {
      theme = 'auto'
    },
    -- tabline = {
    --   lualine_a = {},
    --   lualine_b = {},
    --   -- lualine_c = { require'tabline'.tabline_buffers },
    --   lualine_c = {},
    --   lualine_x = { require'tabline'.tabline_tabs },
    --   lualine_y = {},
    --   lualine_z = {},
    -- }
  }
EOF
endif
