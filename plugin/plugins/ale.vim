if globpath(&rtp, "plugin/ale.vim") == "" | finish | endif

" Lint hooks
let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1
let g:ale_lint_on_save=1

" Linters
let g:ale_linters = {
\ 'javascript': ['eslint', 'flow-language-server'],
\ 'javascript.jsx': ['eslint', 'flow-language-server'],
\ 'typescript': ['eslint', 'tslint', 'tsserver'],
\ }
" \ 'javascript': ['eslint', 'flow-language-server', 'tsserver'],
" \ 'javascript.jsx': ['eslint', 'flow-language-server', 'tsserver'],

" Fixers
let g:ale_fixers = {
\ 'scss': [ 'prettier' ],
\ 'css': [ 'prettier' ],
\ 'markdown': [ 'prettier' ],
\ 'typescript': [ 'prettier', 'tslint' ],
\ 'javascript': [ 'prettier-eslint', 'prettier' ],
\ 'javascript.jsx': [ 'prettier-eslint', 'prettier' ],
\ 'elixir': [ 'mix_format' ],
\ }

" Autofix (https://github.com/w0rp/ale#2ii-fixing)
let g:ale_fix_on_save = 1

" Signs
let g:ale_sign_error = '┅ '
let g:ale_sign_warning = '⊙ '

" Enable completion where available
let g:ale_completion_enabled = 1

" :help ale-compeletion-completeopt-bug
set completeopt=menu,menuone,preview,noselect,noinsert

" Parity with vscode
nnoremap gh :ALEHover<CR>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gD :ALEGoToDefinitionInTab<CR>
nnoremap g* :ALEFindReferences<CR>
