if globpath(&rtp, "plugin/ale.vim") == "" | finish | endif

" Lint hooks
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_insert_leave=1
let g:ale_lint_on_save=1

" Linters
let g:ale_linters = {
\ 'javascript': ['standard', 'flow'],
\ 'html': ['htmlhint'],
\ }

" Fixers
let g:ale_fixers = {
\ 'javascript': [
\   'prettier_standard',
\   'standard',
\   'remove_trailing_lines',
\ ],
\ }

" Autofix (https://github.com/w0rp/ale#2ii-fixing)
let g:ale_fix_on_save = 1

" Signs
let g:ale_sign_error = '! '
let g:ale_sign_warning = '! '

"" [N] <Leader>af -- Ale: fix syntax issues
nmap <Leader>af <Plug>(ale_fix)

