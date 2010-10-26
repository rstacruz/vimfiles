" we need the conceal feature (vim ≥ 7.3)
if !has('conceal')
    finish
endif

syntax match javaScriptFunction /\<function\>/  nextgroup=javaScriptFuncName skipwhite conceal cchar=λ

set conceallevel=2
