if globpath(&rtp, "plugin/ale.vim") == "" | finish | endif

" Lint hooks
let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1
let g:ale_lint_on_save=1

" Linters
let g:ale_linters = {
\ 'javascript': ['standard', 'flow'],
\ 'html': ['htmlhint'],
\ }

" Fixers
let g:ale_fixers = {
\ 'scss': [ 'prettier' ],
\ 'css': [ 'prettier' ],
\ 'javascript': [ 'prettier-eslint' ],
\ }

" Autofix (https://github.com/w0rp/ale#2ii-fixing)
let g:ale_fix_on_save = 1

" Signs
let g:ale_sign_error = '! '
let g:ale_sign_warning = '! '

" Enable completion where available
let g:ale_completion_enabled = 1

"" [N] <Leader>af -- Ale: fix syntax issues
nmap <Leader>af <Plug>(ale_fix)

"" [N] <Leader>ev -- Errors: verify ale setup
"" [N] <Leader>en -- Errors: next
"" [N] <Leader>ep -- Errors: previous
"" [N] <Leader>ec -- Errors: clear errors
nnoremap <Leader>ev :ALEVerify<CR>
nnoremap <Leader>en :ALENextWrap<CR>
nnoremap <Leader>ep :ALEPreviousWrap<CR>
nnoremap <Leader>eN :ALEPreviousWrap<CR>
nnoremap <Leader>ec :ALEResetBuffer<CR>
