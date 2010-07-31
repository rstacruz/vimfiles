" Tidy helper
"
" F2       - Check the file
" F3/F4    - Move to previous/next error
" Shift F3 - Show current error again
" 
exe 'map <F2> :silent ! tidy --show-body-only 1 -quiet % 2>&1 1>/dev/null \| sed "s/line \([0-9]*\) column \([0-9]*\) - \(.*$\)/%:\1:\2: \3 (line \1 column \2)/g" \| cat > '.&errorfile.'<CR>:silent cfile '.&errorfile.'<CR>'
map <S-F3> :cc<CR>
map <F4> :cnext<CR>
map <F3> :cprev<CR>
