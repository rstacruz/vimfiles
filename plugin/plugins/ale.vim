if globpath(&rtp, "plugin/ale.vim") == "" | finish | endif

let g:ale_lint_on_text_changed=0
let g:ale_lint_on_save=1
let g:ale_linters = {
\ 'html': ['htmlhint'],
\ 'javascript': ['standard', 'flow'],
\ }

let g:ale_fixers = {
\ 'javascript': [
\   'prettier_standard',
\   'standard',
\   'remove_trailing_lines',
\ ],
\ }

let g:ale_sign_error = '😳 '
let g:ale_sign_warning = '😳 '

"" [N] <Leader>af -- Ale: fix syntax issues
nmap <Leader>af <Plug>(ale_fix)
