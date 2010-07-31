" Session
" so ~/.vim/session
map <F12> <Esc>:NERDTreeClose<Cr>:mksession! ~/.vim/session<Cr>:echo "Session saved. Press F7 to load it."<Cr>
map <F7> <Esc>:so ~/.vim/session<Cr>:set lsp=1<Cr>

