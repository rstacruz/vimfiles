" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ }

" let g:LanguageClient_serverCommands = {
"   \ 'javascript': ['flow-language-server', '--stdio', '--try-flow-bin'],
"   \ 'javascript.jsx': ['flow-language-server', '--stdio', '--try-flow-bin'],
"   \ }s
