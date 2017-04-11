if globpath(&rtp, "plugin/ale.vim") == "" | finish | endif

let g:ale_lint_on_text_changed=0
let g:ale_lint_on_save=1
let g:ale_linters = {
\ 'html': ['htmlhint'],
\ }

let g:ale_sign_error = '› '
let g:ale_sign_warning = '› '
