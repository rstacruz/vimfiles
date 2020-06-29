" https://github.com/raghur/vim-ghost#configuring-filetype
function! s:SetupGhostBuffer()
    if match(expand("%:a"), '\v/ghost-(github|reddit)\.com-')
        set ft=markdown
    endif
endfunction

augroup vim-ghost
    au!
    au User vim-ghost#connected call s:SetupGhostBuffer()
augroup END
