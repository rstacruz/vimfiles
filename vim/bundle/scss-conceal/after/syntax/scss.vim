if has('conceal')
    syntax clear scssInclude
    syntax match scssInclude "@include" conceal cchar=✓
    hi link scssInclude Statement
endif

