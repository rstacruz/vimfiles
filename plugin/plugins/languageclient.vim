" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ }

" let g:LanguageClient_serverCommands = {
"   \ 'javascript': ['flow-language-server', '--stdio', '--try-flow-bin'],
"   \ 'javascript.jsx': ['flow-language-server', '--stdio', '--try-flow-bin'],
"   \ }

nnoremap <c-m><c-m> :call LanguageClient_contextMenu()<CR>

" Or map each action separately
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>mr :call LanguageClient#textDocument_rename()<CR>
