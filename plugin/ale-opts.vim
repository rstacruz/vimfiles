let g:ale_set_balloons=1
let g:ale_hover_to_preview=1
let g:ale_floating_preview=1
let g:ale_floating_window_border=['│', '─', '╭', '╮', '╯', '╰']

" let g:ale_fix_on_save=1

let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'javascriptreact': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ 'css': ['prettier'],
\}

" volta install @fsouza/prettierd
" To fix prettier, edit:
"    ~/.vim/vendor/ale/autoload/ale/fixers/prettier.vimk
" And change:
"   \ '%e --version',
" To this:
"   \ 'prettier --version',
" let g:ale_javascript_prettier_executable = 'prettierd'
" let g:ale_javascript_prettier_use_global = 1
