" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {}

" yarn global add vscode-css-languageserver-bin
" https://github.com/vscode-langservers/vscode-css-languageserver-bin
if executable('css-languageserver')
  let g:LanguageClient_serverCommands = extend(g:LanguageClient_serverCommands, {
  \ 'css': ['css-languageserver', '--stdio' ],
  \ 'scss': ['css-languageserver', '--stdio' ],
  \ 'sass': ['css-languageserver', '--stdio' ],
  \ 'less': ['css-languageserver', '--stdio' ],
  \ })
endif

" yarn global add flow-language-server
" https://github.com/flowtype/flow-language-server
if executable('flow-language-server')
  let g:LanguageClient_serverCommands = extend(g:LanguageClient_serverCommands, {
    \ 'javascript': ['flow-language-server', '--stdio', '--try-flow-bin'],
    \ 'javascript.jsx': ['flow-language-server', '--stdio', '--try-flow-bin'],
    \ })
endif

" \ 'javascript': ['javascript-typescript-stdio'],
" \ 'javascript.jsx': ['javascript-typescript-stdio'],
