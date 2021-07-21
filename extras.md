# Extras

Some plugins that I used to use, but chosen not to load anymore:

```viml
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
```
