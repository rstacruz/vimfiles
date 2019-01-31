if globpath(&rtp, "plugin/ale.vim") == "" | finish | endif

" Lint/fix hooks
let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1
let g:ale_lint_on_save=1
let g:ale_fix_on_save = 1

" Enable completion where available
let g:ale_completion_enabled = 1

" Linters
let g:ale_linters = {
\ 'javascript': ['eslint', 'tsserver'],
\ 'javascript.jsx': ['eslint', 'tsserver'],
\ 'typescript': ['tsserver'],
\ }
", 'flow-language-server'],

" Fixers
let g:ale_fixers = {
\ 'scss': [ 'prettier' ],
\ 'css': [ 'prettier' ],
\ 'markdown': [ 'prettier' ],
\ 'typescript': [ 'prettier', 'tslint' ],
\ 'javascript': [ 'prettier', 'prettier' ],
\ 'javascript.jsx': [ 'prettier-eslint', 'prettier' ],
\ 'elixir': [ 'mix_format' ],
\ }

" Signs
let g:ale_sign_error = '━ '
let g:ale_sign_warning = '─ '

" :help ale-compeletion-completeopt-bug
set completeopt=menu,menuone,preview,noselect,noinsert

" Parity with vscode
nnoremap gh :ALEHover<CR>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gD :ALEGoToDefinitionInTab<CR>
nnoremap g* :ALEFindReferences<CR>
