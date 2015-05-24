if globpath(&rtp, "syntax/javascript.vim") == ""
  finish
endif

let g:javascript_conceal = 1
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
" let g:javascript_conceal_null       = "ø"
" let g:javascript_conceal_undefined  = "¿"
" let g:javascript_conceal_NaN        = "ℕ"
" let g:javascript_conceal_prototype  = "¶"
" let g:javascript_conceal_static     = "•"
" let g:javascript_conceal_super      = "Ω"
"
augroup javascript
  au!
  au BufNewFile,BufRead *.es6 setf javascript
augroup END
