# Extras

Some plugins that I used to use, but chosen not to load anymore:

```viml
" neovim: define themes declaratively
Plug 'rktjmp/lush.nvim'

" there's an nvim equivalent
Plug 'junegunn/goyo.vim'

" git log viewer. very fiew times i've used it
Plug 'junegunn/gv.vim'

" finder for lsp symbols. I don't use it
Plug 'liuchengxu/vista.vim'

" polyglot has its own implementation
Plug 'tpope/vim-sleuth'

" session management, i don't really use it
Plug 'dhruvasagar/vim-prosession'

" I never used it too much
Plug 'arithran/vim-delete-hidden-buffers'

# Only useful for ruby and I'd rather up-enter
Plug 'janko/vim-test'

# Fzf does it as well, and doesn't colour-shift
Plug 'liuchengxu/vim-clap'

" Dunno, just not useful, and I use `s` a lot in my workflow
Plug 'justinmk/vim-sneak'

" Has the .git/index.lock bug
Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': ':UpdateRemotePlugins' }

" Cute, doesn't add too much value for me
Plug 't9md/vim-choosewin'

" vim-markdown with its `ge` binding is pretty useful on its own
Plug 'vimwiki/vimwiki'

" 'npx mdv' is already pretty good
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'junegunn/vim-slash'
Plug 'SirVer/ultisnips'
Plug 'freitass/todo.txt-vim'

Plug vim . '/modules/lolcolor'
Plug vim . '/modules/quickterm'
Plug vim . '/modules/startify-switcher'
Plug 'cweagans/vim-taskpaper'
```

## Themes

```viml
" Themes
Plug 'ghifarit53/daycula-vim'
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
Plug 'lifepillar/vim-colortemplate'
Plug 'owickstrom/vim-colors-paramount'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'equt/paper.vim'
Plug 'habamax/vim-sugarlily'
```
