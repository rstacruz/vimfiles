" we need the conceal feature (vim ≥ 7.3)
if !has('conceal')
    finish
endif

" remove the keywords. we'll re-add them below
syntax match rbNiceOperator "<=" conceal cchar=≤
syntax match rbNiceOperator ">=" conceal cchar=≥
syntax match rbNiceOperator "==" conceal cchar=≡
syntax match rbNiceOperator "!=" conceal cchar=≠

syntax keyword rbNiceStatement lambda conceal cchar=λ

hi link rbNiceOperator Operator
hi link rbNiceOperator Statement
hi! link Conceal Operator

set conceallevel=2
