if globpath(&rtp, "plugin/ale.vim") == "" | finish | endif

" Lint on normal mode
let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1
let g:ale_lint_on_save = 1

" Run fixer (eg, prettier) on save
let g:ale_fix_on_save = 1

" Enable completion where available
let g:ale_completion_enabled = 1

" Signs
let g:ale_sign_error = '━ '
let g:ale_sign_warning = '─ '

" :help ale-compeletion-completeopt-bug
set completeopt=menu,menuone,preview,noselect,noinsert

" Inspired by vscode-vim's key bindings
nnoremap gh :ALEHover<CR>
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gD :ALEGoToDefinitionInTab<CR>
nnoremap g* :ALEFindReferences<CR>

let g:ale_fixers = {
      \ 'typescript': ['prettier', 'tslint'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'css': ['prettier', 'stylelint'],
      \ 'sass': ['prettier', 'stylelint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ 'markdown': ['prettier']
      \ }
