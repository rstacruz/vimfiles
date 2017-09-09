if $GIT_DIR != "" | finish | endif

" Expands 'class=' to 'className='
augroup jsxclass
  au!
  au FileType javascript.jsx iabbrev class== className=
augroup END
